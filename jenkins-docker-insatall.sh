#Install Jenkins on Ubuntu
#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jre -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -q -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins

# install Docker
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo systemctl stop docker
sudo systemctl disable docker
sudo systemctl start docker
sudo systemctl enable docker