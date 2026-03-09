def buildJar() {
	echo "Building JAR file ..."
	sh "mvn clean package"
}

def buildAndPushImage() {
	echo "Building docker image ..."
	sh "cd ./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/"
	withCredentials( [
		usernamePassword( credentials: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
						passwordVariable: 'DOCKER_PASSWORD' )
	]) {
		echo "Pushing docker image to Docker Hub ..."
		sh "docker build -t devct/demo-java-app:${VERSION} ."
		sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
		sh "docker push devct/demo-java-app:${VERSION}"
	}
}

return this
