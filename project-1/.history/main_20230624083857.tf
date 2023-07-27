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

resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc_id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
# Create EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg]

  tags = {
    Name = local.Name
    Method = local.Method
  }
}
#creating output variable

output "public_ip" {
  value = aws_instance.app_server.public_ip
}