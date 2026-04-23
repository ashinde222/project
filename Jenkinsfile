pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    stages {

        stage('Clone repo') {
            steps {
                git branch: 'Master', url: 'https://github.com/ashinde222/project.git'
            }
        }

        stage('Build War') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Deploy containers') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }

    }
}
