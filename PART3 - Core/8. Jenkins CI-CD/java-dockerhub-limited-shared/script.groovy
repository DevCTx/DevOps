#!/usr/bin/env groovy

def testApp() {
	echo "Test Java App ..."
	sh "mvn --no-transfer-progress test"
}

return this
