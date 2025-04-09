pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Set Branch Name') {
            steps {
                script {
                    // Remove "origin/" if present
                    env.BRANCH_NAME = "${env.GIT_BRANCH}".replaceFirst(/^origin\//, '')
                }
            }
        }

        stage('Print Branch Name') {
            steps {
                echo "Branch from env variable: ${env.BRANCH_NAME}"
                sh 'echo Branch from shell: $BRANCH_NAME'
            }
        }

        stage('Build Docker Image & Push') {
            steps {
                sh 'chmod +x ./build.sh'
                sh "./build.sh ${env.BRANCH_NAME}"
            }
        }

        stage('Deploy Application') {
            steps {
                sh 'chmod +x ./deploy.sh'
                sh "./deploy.sh ${env.BRANCH_NAME}"
            }
        }
    }

    triggers {
        githubPush()
    }
}
