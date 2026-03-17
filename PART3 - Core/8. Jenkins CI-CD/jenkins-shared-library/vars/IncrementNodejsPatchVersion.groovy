#!/usr/bin/env groovy

def call() {
    echo "Incrementing NodeJS patch version ..."
    def version = sh(
        script: "npm version patch --no-git-tag-version", 
        returnStdout: true
    ).trim()
    version = version.replace("v", "")
}

