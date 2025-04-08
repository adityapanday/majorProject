pipeline {
    agent any
  
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image & Push') {
            steps {
                sh 'chmod +x build.sh'
                sh "./build.sh ${env.BRANCH_NAME}"
                // sh './build.sh'
            }
        }

        stage('Deploy Application') {
            steps {
                sh 'chmod +x deploy.sh'
                sh "./deploy.sh ${env.BRANCH_NAME}"
            }
        }
    }

    triggers {
        githubPush()
    }
}

