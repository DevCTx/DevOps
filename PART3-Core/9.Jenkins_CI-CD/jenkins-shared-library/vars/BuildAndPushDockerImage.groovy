#!/usr/bin/env groovy

// Function to clean, build, and push a Docker image
def call(String credentialsId, String imageName, String version) {
    withCredentials([
        usernamePassword(
            credentialsId: credentialsId,
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )
    ]) {
        // Quick environment check
        echo "Checking Docker environment..."
        sh "whoami && id && docker --version && docker ps"

        // Remove all old images of this repository
        echo "Removing all existing images of ${imageName} skipping in-use images..."
        sh "docker images ${imageName} -q | xargs -r -n1 docker rmi -f || true"

        // Build the new image
        echo "Building new image ${imageName}:${version}..."
        sh "docker build -t ${imageName}:${version} ."

        // Login and push
        echo "Docker login and push image..."
        sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"
        sh "docker push ${imageName}:${version}"
    }
}
