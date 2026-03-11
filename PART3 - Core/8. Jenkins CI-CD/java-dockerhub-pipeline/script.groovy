#!/usr/bin/env groovy

def testApp() {
	echo "testApp()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"

    	echo "Test Java App ..."
    	sh "mvn test"
    }
}

def buildJar() {
	echo "buildjar()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"

    	echo "Building JAR file ..."
    	sh "mvn --no-transfer-progress clean package"
    }
}

def buildAndPushImage() {
	echo "buildAndPushImage()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"

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

        	echo "docker build image ..."
		    sh "docker build -t devct/demo-java-app:${params.VERSION} ."
        	echo "login docker ..."
		    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
        	echo "docker push image ..."
		    sh "docker push devct/demo-java-app:${params.VERSION}"
	    }
    }
}

return this
