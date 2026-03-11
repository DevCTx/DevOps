#!/usr/bin/env groovy

def call() {
    echo "withCredentials"
    withCredentials( [
        usernamePassword( credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
				        passwordVariable: 'DOCKER_PASSWORD' )
    ]) {
        // Diagnoses 90% of jenkins+docker errors
        echo "check docker"
        sh "whoami"
        sh "id"
        sh "docker --version"
        sh "docker ps"

	    echo "docker build and push image ..."
        sh "docker build -t devct/demo-java-app:${params.VERSION} ."
        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
        sh "docker push devct/demo-java-app:${params.VERSION}"
    }
}
