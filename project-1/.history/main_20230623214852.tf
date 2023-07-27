terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "Terraform"
  region = "us-east-2"
}

#Creating an input variable
variable "instance_type" {
  type = string
}

# Create EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = var.instance_type

  tags = {
    Name = "Ubuntu-Test-Instance"
    Method = "Terraform"
  }
}
#Create output Variables
output "public_ip" {
  value = aws_instance.app_server.public_ip
}
tags = {
    Name = local.Name
    Method = local.Method
  }