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
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = "ami-074cce78125f09d61"
  instance_type = var.TF_VAR_instance_type

  tags = {
    Name = var.TF_VAR_instance_name
  }
}
