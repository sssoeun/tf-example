terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "172.16.20.0/24"
  tags = {
    Name = "simple-vpc"
  }
}

resource "aws_instance" "simple" {
  ami                    = "ami-056a29f2eddc40520"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  tags = {
    Name = "simple-server"
  }
  user_data = <<-EOF
        #!/bin/bash
        echo "Hello, Terraform!!">index.html
        nohup busybox httpd -f -p "${var.web_port}"} &
        EOF
}

resource "aws_security_group" "instance" {
  name = "simple-web-sg"
  ingress {
    from_port   = var.web_port
    to_port     = var.web_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


