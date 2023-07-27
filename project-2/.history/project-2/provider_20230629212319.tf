terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Group-3-Work-Space"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region = "us-east-2"
}