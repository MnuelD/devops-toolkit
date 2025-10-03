
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Setup DevOps Toolkit') {
            steps {
                sh 'bash actions/cleanup.sh'
                sh 'bash actions/setup.sh'
            }
        }
    }
}
