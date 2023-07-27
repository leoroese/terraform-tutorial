terraform {
  cloud {
    organization = "Org101"

    workspaces {
      name = "super-space"
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
  region = "us-east-1"
}