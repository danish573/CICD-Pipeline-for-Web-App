terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"] # Canonical
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

resource "aws_instance" "jenkins_instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type =var.instances_type
    key_name =  var.key_name
    user_data = file("jenkins-installation.sh")
    security_groups = [aws_security_group.s_group.name]

    tags = {
        Name = "JenkinsInstance"
    }
}

data "aws_ami" "AmazonLinux2" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "app_deployment" {
    ami = data.aws_ami.AmazonLinux2.id
    instance_type = var.instances_type
    key_name = var.key_name
    user_data = file("docker-insallation.sh")
    security_groups = [aws_security_group.s_group.name]

    tags = {
        Name = "AppDeploymentInstance"
    }
}

resource "aws_security_group" "s_group" {
  description = "Allow SSH and HTTP traffic"
  name = "ci-cd-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  tags = {
    name = "ci-cd-sg"
  }
}

