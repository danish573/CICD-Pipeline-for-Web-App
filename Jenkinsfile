pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'dkhan573/myapp:latest'
        EC2_HOST = 'ec2-user@54.234.27.138'
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/danish573/CICD-Pipeline-for-Web-App.git'
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
                    sh """
ssh -o StrictHostKeyChecking=no $EC2_HOST << EOF
docker rm -f flask-container || true
docker pull $DOCKER_IMAGE
docker run -d --name flask-container -p 5000:5000 $DOCKER_IMAGE
EOF
                    """
                }
            }
        }
    }
}
