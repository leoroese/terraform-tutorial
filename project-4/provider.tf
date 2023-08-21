/*(terraform {
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
}*/


terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "K8s_setup"
    }
  }
  required_providers {
    aws= {
        source = "hashicorp/aws"
        version = "5.5.0"
    }
}
}

provider "aws" {
  region = "us-west-1"
}

