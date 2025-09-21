pipeline {
    agent any
    tools {
        jdk 'jdk17'   // corrected: was "jkd"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        TMDB_API_KEY = credentials('TMDB') 
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
       stage("Quality Gate") {
    
          steps {
              timeout(time: 10, unit: 'MINUTES') {
               waitForQualityGate abortPipeline: true
              }
          }
       }
        stage("trivy scan"){
            steps{
                sh 'trivy fs .'
            }
        }

        stage("build the image"){
            steps{
                docker build -t netflix --build-args 'TMDM-v4-API-KEY'=${TMDB_API_KEY} .
            }
        }
    }
}