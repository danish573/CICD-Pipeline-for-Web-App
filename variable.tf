
variable "region" {
    description = "AWS region to deploy resources"
    type        = string
    default     = "us-east-1"
}

variable "key_name" {
    description = "Name of the SSH key pair to use for EC2 instances"
    type        = string
    default     = "Linux1"
}

variable "instances_type" {
    description = "Type of EC2 instance to launch"
    type        = string
    default     = "t2.micro"
}