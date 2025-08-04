#!/bin/bash

# Update system packages
sudo apt update -y
sudo apt upgrade -y

# Install Java (Jenkins requires Java 11 or higher)
sudo apt install openjdk-11-jdk -y

# Add Jenkins key and repository
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins
sudo apt update -y
sudo apt install jenkins -y

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Docker
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo systemctl enable docker
