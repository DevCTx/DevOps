def buildJar() {
	echo "buildjar()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"

    	echo "Building JAR file ..."
    	sh "mvn clean package"
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
        	echo "docker build image ..."
		    sh "docker build -t devct/demo-java-app:${VERSION} ."
        	echo "login docker ..."
		    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
        	echo "docker push image ..."
		    sh "docker push devct/demo-java-app:${VERSION}"
	    }
    }
}

return this
