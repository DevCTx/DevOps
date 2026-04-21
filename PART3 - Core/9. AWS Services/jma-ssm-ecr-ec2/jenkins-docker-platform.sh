#!/bin/bash
set -e

echo "=== Install Docker ==="
apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker


########################################
# Structure
########################################

mkdir -p ~/jenkins/controller
mkdir -p ~/jenkins/agents/{docker,nodejs,maven,aws}

########################################
# Jenkins Controller (clean)
########################################

cat > ~/jenkins/controller/Dockerfile <<EOF
FROM jenkins/jenkins:lts

USER root

ARG DOCKER_GID=999

RUN apt-get update && apt-get install -y \
    git \
    curl \
    docker.io && \
    apt-get clean

RUN groupadd -g ${DOCKER_GID} docker || true &&  usermod -aG docker jenkins

# Plugins essentiels CI/CD
RUN jenkins-plugin-cli --plugins \
    workflow-aggregator \
    git \
    pipeline-stage-view \
    credentials-binding \
    ssh-slaves

USER jenkins
EOF

########################################
# Docker Agent (build images)
########################################

cat > ~/jenkins/agents/docker/Dockerfile <<EOF
FROM jenkins/inbound-agent

USER root

ARG DOCKER_GID=999

RUN apt-get update && apt-get install -y \
    git \
    curl \
    docker.io \
    ca-certificates && \
    apt-get clean

# accès docker host
RUN groupmod -g ${DOCKER_GID} docker || true && usermod -aG docker jenkins

USER jenkins
EOF

########################################
# NodeJS Agent
########################################

cat > ~/jenkins/agents/nodejs/Dockerfile <<EOF
FROM jenkins/inbound-agent

USER root

RUN apt-get update && apt-get install -y curl git && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

USER jenkins
EOF

########################################
# Maven Agent
########################################

cat > ~/jenkins/agents/maven/Dockerfile <<EOF
FROM jenkins/inbound-agent

USER root

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    maven \
    git && \
    apt-get clean

USER jenkins
EOF

########################################
# AWS Agent
########################################

cat > ~/jenkins/agents/aws/Dockerfile <<EOF
FROM jenkins/inbound-agent

USER root

RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates && \
    apt-get clean

# AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

USER jenkins
EOF

########################################
# Build images
########################################

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

  docker run --rm \
    --entrypoint bash \
    -v /var/run/docker.sock:/var/run/docker.sock \
    $IMAGE \
    -c "$CMD"
}

test_agent jenkins-docker-agent "docker version"
test_agent jenkins-maven-agent "mvn -v"
test_agent jenkins-nodejs-agent "node -v && npm -v"
test_agent jenkins-aws-agent "aws --version"


########################################
# Run Jenkins Controller
########################################

docker rm -f jenkins 2>/dev/null || true

docker run -d \
  --name jenkins \
  --restart unless-stopped \
  --init \
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
echo "✅ Jenkins ready:"
echo "http://$(hostname -I | awk '{print $1}'):8080"
echo ""

echo "🔑 Admin password:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
echo ""
