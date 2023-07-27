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

provider "aws" {
  profile = "Terraform"
  region = "us-east-1"
  alias = "us"
}

