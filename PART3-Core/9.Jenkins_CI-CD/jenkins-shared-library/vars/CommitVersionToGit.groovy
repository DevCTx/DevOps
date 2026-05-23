#!/usr/bin/env groovy

// Function to commit version changes to Git
def call(String credentialsId, String commitMessage = "CI: version update") {
    withCredentials([
        usernamePassword(
            credentialsId: credentialsId,
            usernameVariable: 'GIT_USER',
            passwordVariable: 'GIT_PASS'
        )
    ]) {
        echo "Updating version in Git repository..."
        sh """
            git config user.email 'jenkins@example.com'
            git config user.name 'jenkins'
            git remote set-url origin https://\${GIT_USER}:\${GIT_PASS}@github.com/DevCTx/DevOps.git
            git add .
            git status
            git diff --cached --quiet || git commit -m '${commitMessage}'
            git push origin HEAD:main
        """
    }
}
