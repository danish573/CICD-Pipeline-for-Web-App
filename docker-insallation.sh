# Update and install Docker
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo yum install docker -y

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group (optional, for non-root use)
sudo usermod -aG docker ec2-user

