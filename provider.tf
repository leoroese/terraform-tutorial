terraform {
  backend "remote" {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Git_Terraform_Tutoria"
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
  