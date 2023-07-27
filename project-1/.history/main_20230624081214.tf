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

#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

locals {
  Name = "My-Test-Instance"
  Method = "terraform"
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Create EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = var.instance_type

  tags = {
    Name = local.Name
    Method = local.Method
  }
}
#creating output variable

output "public_ip" {
  value = aws_instance.app_server.public_ip
}