def buildJar() {
	echo "Building JAR file ..."
	sh "mvn clean package"
}

def buildAndPushImage() {
	echo "Building docker image ..."
	sh "cd ./PART3 - Core/8. Jenkins CI-CD/java-maven-app"
	withCredentials( [
		usernamePassword( credentials: '', 
											usernameVariable: 'DOCKER_USERNAME',
											passwordVariable: 'DOCKER_PASSWORD' )
	]) {
		echo "Pushing docker image to Docker Hub ..."
		sh "docker build -t devctx/java-app-pipeline:1.0 ."
		sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
		sh "docker push devctx/java-app-pipeline:1.0"
	}
}

return this
