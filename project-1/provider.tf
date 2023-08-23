terraform {
  cloud {
    organization = "Abingwas-Foundation"

    workspaces {
      name = "Hyper-V_setup"
    }
  }
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = ">= 1.0.3"
    }
  }
}

provider "hyperv" {
}