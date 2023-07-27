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

#create Subnebt
resource "aws_subnet" "main" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"
}


  
#Create Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

#Creating Dynamic block for ingress
  dynamic "ingress" {
    description      = ingress.inbound_rules.description
    from_port        = ingress.inbound_rules.port
    to_port          = ingress.inbound_rules.port
    protocol         = "tcp"
   cidr_blocks        = ingress.inbound_rules.subnet
  }
   
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}