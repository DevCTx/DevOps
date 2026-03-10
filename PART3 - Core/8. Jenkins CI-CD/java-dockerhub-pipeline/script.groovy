def buildJar() {
	echo "Building JAR file ..."

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"
    	sh "mvn clean package"
    }
}

def buildAndPushImage() {
	echo "Building docker image ..."

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
	    withCredentials( [
		    usernamePassword( credentialsId: 'dockerhub-credentials',
                            usernameVariable: 'DOCKER_USERNAME',
						    passwordVariable: 'DOCKER_PASSWORD' )
	    ]) {
		    echo "Pushing docker image to Docker Hub ..."
		    sh "docker build -t devct/demo-java-app:${VERSION} ."
		    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
		    sh "docker push devct/demo-java-app:${VERSION}"
	    }
    }
}

return this
