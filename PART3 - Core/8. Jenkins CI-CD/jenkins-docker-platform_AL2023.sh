#!/bin/bash
#
# This script installs a full Jenkins Docker Controller with agents
# on Red Hat Enterprise Linux System (AWS Linux Amazon 2023)
# 
# Jenkins Controller → orchestration only, CI/CD Plugins
# ├── jenkins-docker-agent → build Docker images, docker socket access
# ├── jenkins-nodejs-agent → React/Node Builds
# ├── jenkins-maven-agent → Java Builds
# └── jenkins-aws-agent → AWS deployment
#

set -e

echo "=== Docker Already installed on HOST (AWS) ==="
# dnf update -y
# dnf install -y docker

# systemctl enable docker
# systemctl start docker

# usermod -aG docker ec2-user

########################################
# Structure
########################################

mkdir -p ~/jenkins/controller
mkdir -p ~/jenkins/agents/{docker,nodejs,maven,aws}

########################################
# Jenkins Controller (clean)
########################################

cat > ~/jenkins/controller/Dockerfile <<'EOF'
FROM jenkins/jenkins:lts

USER root

ARG DOCKER_GID=999

RUN apt-get update && apt-get install -y ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
    git \
    curl \
    docker-ce-cli && \
    apt-get clean

RUN set -eux; \
    if getent group docker; then \
        groupmod -g ${DOCKER_GID} docker; \
    else \
        groupadd -g ${DOCKER_GID} docker; \
    fi; \
    usermod -aG docker jenkins

# Essential CI/CD Plugins
RUN jenkins-plugin-cli --plugins \
    workflow-aggregator \
    git \
    pipeline-stage-view \
    credentials-binding \
    docker-plugin \
    docker-workflow \
    ssh-slaves

USER jenkins
EOF

########################################
# Docker Agent (build images)
########################################

cat > ~/jenkins/agents/docker/Dockerfile <<'EOF'
FROM jenkins/inbound-agent

USER root

ARG DOCKER_GID=999

RUN apt-get update && apt-get install -y ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
    git \
    curl \
    docker-ce-cli \
    ca-certificates && \
    apt-get clean

RUN set -eux; \
    if getent group docker; then \
        groupmod -g ${DOCKER_GID} docker; \
    else \
        groupadd -g ${DOCKER_GID} docker; \
    fi; \
    usermod -aG docker jenkins

USER jenkins
EOF

########################################
# NodeJS Agent
########################################

cat > ~/jenkins/agents/nodejs/Dockerfile <<'EOF'
FROM jenkins/inbound-agent

USER root

RUN apt-get update && apt-get install -y curl git ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && \
    apt-get clean

RUN node --version && npm --version && \
    npm install -g npm@latest

ENV npm_config_cache=/tmp/npm-cache

USER jenkins
EOF

########################################
# Maven Agent
########################################

cat > ~/jenkins/agents/maven/Dockerfile <<'EOF'
FROM jenkins/inbound-agent

USER root

ARG MAVEN_VERSION=3.9.15

RUN apt-get update && apt-get install -y \
    curl \
    git && \
    apt-get clean

RUN curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
        | tar -xzf - -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven

ENV PATH="/opt/maven/bin:$PATH"
ENV MAVEN_HOME=/opt/maven

RUN java -version && mvn -v

USER jenkins
EOF

########################################
# AWS Agent
########################################

cat > ~/jenkins/agents/aws/Dockerfile <<'EOF'
FROM jenkins/inbound-agent

USER root

RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates && \
    apt-get clean

# AWS CLI v2
RUN ARCH=$(uname -m) && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    aws --version

# kubectl (EKS)
RUN ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/') && \
    curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/${ARCH}/kubectl" && \
    install -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    kubectl version --client

USER jenkins
EOF

########################################
# Build images
########################################
set -e
export DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
echo "DOCKER_GID=${DOCKER_GID}"

echo "=== Build Controller ==="
cd ~/jenkins/controller
docker build --no-cache --build-arg DOCKER_GID=$DOCKER_GID -t jenkins-controller .

echo "=== Build Agents ==="

echo "--- Building docker agent ---"
cd ~/jenkins/agents/docker
docker build --no-cache --build-arg DOCKER_GID=$DOCKER_GID -t jenkins-docker-agent .

for agent in nodejs maven aws; do
  echo "--- Building $agent agent ---"
  cd ~/jenkins/agents/$agent
  docker build --no-cache -t jenkins-$agent-agent .
done


########################################
# Test agent images
########################################

test_agent () {
  IMAGE=$1
  CMD=$2

  echo ""
  echo "=== Testing $IMAGE ==="

  if docker run --rm \
    --name $IMAGE \
    --entrypoint bash \
    $IMAGE \
    -c "$CMD"; then
    echo "✅ $IMAGE OK"
  else
    echo "❌ $IMAGE FAILED"
    exit 1
  fi
}


echo ""
echo "=== Testing jenkins-docker-agent ==="

if docker run --rm \
  --name jenkins-docker-agent \
  --entrypoint bash \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-docker-agent \
  -c "docker --version" ; then
    echo "✅ jenkins-docker-agent OK"
  else
    echo "❌ jenkins-docker-agent FAILED"
    exit 1
  fi


test_agent jenkins-maven-agent  "mvn -v"
test_agent jenkins-nodejs-agent "node -v && npm -v"
test_agent jenkins-aws-agent    "aws --version && kubectl version --client"


########################################
# Run Jenkins Controller
########################################

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

docker rm -f jenkins 2>/dev/null || true

docker run -d \
  --name jenkins \
  --restart unless-stopped \
  --init \
  --memory=2g \
  --cpus=2 \
  --log-driver json-file \
  --log-opt max-size=50m \
  --log-opt max-file=3 \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add $DOCKER_GID \
  jenkins-controller

########################################
# Output
########################################

echo ""
echo "⏳ Waiting Jenkins to be ready..."

MAX_WAIT=120
ELAPSED=0
until curl -s http://localhost:8080/login >/dev/null; do
  echo "waiting ..."
  sleep 3

  ELAPSED=$((ELAPSED + 3))
  if [ $ELAPSED -ge $MAX_WAIT ]; then
    echo "❌ Jenkins did not start after ${MAX_WAIT}s"
    docker logs jenkins --tail 50
    exit 1
  fi
done

echo ""
echo "✅ Jenkins ready:"

echo ""
PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP : http://${PRIVATE_IP}:8080"

echo ""
# 169.254.169.254 is a special adress accessible only from the server
# Ask for a token
TOKEN=$(curl -s -X PUT \
  "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
# Ask for private server information with the token
PUBLIC_IP=$(curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/public-ipv4)
if [ -n "$PUBLIC_IP" ]; then
  echo "PUBLIC_IP : http://${PUBLIC_IP}:8080"
else
  echo "PUBLIC_IP : not available"
fi

echo ""
echo "🔑 Admin password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
echo ""
