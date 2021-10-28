terraform {
  backend "remote" {
    organization = "terraform-tutorial-leo"

    workspaces {
      name = "terraform-tutorial-flow-vcs"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ba62214afa52bec7"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
