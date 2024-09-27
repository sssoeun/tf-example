terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" { 
region = "ap-northeast-2"
}


resource "aws_instance" "simple" {
ami         = "ami-056a29f2eddc40520" 
instance_type = "t3.micro"
}
