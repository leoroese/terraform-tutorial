terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Hyper-V_setup"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
}