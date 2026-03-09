def buildApp() {
	echo "Building version ${params.VERSION}"
}

def testApp() {
	if (params.RUN_TESTS) {
		echo "Running tests"
	}
}

def deployApp() {
	echo "Deploying to ${params.ENV}"
}

return this
