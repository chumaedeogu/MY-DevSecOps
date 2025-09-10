pipeline {
    agent any
    tools {
        jdk 'jdk17'   // corrected: was "jkd"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage("Cleanup") {
            steps {
                cleanWs()   // corrected: was cleanWS()
            }
        }

        stage("Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/chumaedeogu/MY-DevSecOps.git'
            }
        }

        stage("Static analysis with SonarQube") {
            steps {
                withSonarQubeEnv('sonar') {   // 'sonar' must match the name you configured in Jenkins > Manage Jenkins > System > SonarQube servers
                    sh """
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=myProjectKey \
                        -Dsonar.sources=.
                    """
                }
            }
        }
    }
}