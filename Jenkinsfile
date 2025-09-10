pipeline{
    agent any
    tools {
        jkd 'jdk17'
        }
    environment{
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages{
        stage("Cleaup"){
            steps{
                cleanWS()
            }
            
        }
    }
    
        stage("checkup"){
            steps{
                git branch:main, url:'https://github.com/chumaedeogu/MY-DevSecOps.git'
            }
            
        }

   
        stage("Static analysis with sonaqube"){
            steps{
               withSonarQubeEnv('sonar') {
             sh """
        $SCANNER_HOME/bin/sonar-scanner \
        -Dsonar.projectKey=myProjectKey \
        -Dsonar.sources=. 
        
            """
                }
            }
            
        }
    }


