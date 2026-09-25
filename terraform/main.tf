terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "aws-devops-handson-terraform-state-295028317770"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "react_sg" {
  name        = "react-app-sg"
  description = "Allow SSH and React traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "React App"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "react_server" {
  ami           = "ami-0769f265f707fecc8"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.react_sg.id]

  key_name = "day9-key"

  tags = {
    Name = "React-App-Server"
  }
}
