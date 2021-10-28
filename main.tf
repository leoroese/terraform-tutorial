terraform {
  backend "remote" {
    organization = "documentation-nerds"
    workspaces {
      name = "terraform-tutorial"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-074cce78125f09d61"
  instance_type = var.TF_VAR_instance_type

  tags = {
    Name = var.TF_VAR_instance_name
  }
}


variable "TF_VAR_instance_type" {
  description = "Value of the EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "TF_VAR_instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

