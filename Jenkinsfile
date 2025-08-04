pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'dkhan573/myapp:latest'
    }

    stages {
        stage('Clone Code') {
            steps {
                git 'https://github.com/yourusername/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@<EC2-PUBLIC-IP> "docker pull $DOCKER_IMAGE && docker run -d -p 80:5000 $DOCKER_IMAGE"'
                }
            }
        }
    }
}
