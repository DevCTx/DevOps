#!/usr/bin/env groovy

def testApp() {
	echo "testApp()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"

    	echo "Test Java App ..."
    	sh "mvn --no-transfer-progress test"
    }
}

def buildJar() {
	echo "buildjar()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"
    }
}

def buildAndPushImage() {
	echo "buildAndPushImage()"

    dir("./PART3 - Core/8. Jenkins CI-CD/java-dockerhub-pipeline/") {
        sh "pwd"
        sh "ls -la"
    }
}

return this
