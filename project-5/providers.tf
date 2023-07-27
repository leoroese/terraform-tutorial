terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Git_Terraform_Tutoria"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}