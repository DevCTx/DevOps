#!/usr/bin/env groovy

def call() {
    echo "Running NodeJS test ..."
    sh "npm install"
    sh "npm run test"
}

