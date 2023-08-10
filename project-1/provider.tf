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
  profile = "default"
  region = "us-west-1"
}

/*provider "aws" {
  profile = "Terraform"
  region = "us-east-1"
  alias = "us"
}*/

