/*terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Group-3-Work-Space"
    }
  }
}

provider "aws" {
  profile = "terraform"
}*/

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
