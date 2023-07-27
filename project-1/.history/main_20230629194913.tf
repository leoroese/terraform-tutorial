

#create a VPC
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

#Create Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

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
    Name = "allow_ssh"
  }
}

# Create EC2 instance the vpc_security_group_ids is refrence from the security resource, the subnet_id is refrence from the vpc module where [0] represent the first string of the public_subnet list. 
#To enable public IP, we enable subnet_id to true.
resource "aws_instance" "app_server" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  count = 5
  tags = {
    Name = local.Name
    Method = local.Method
  }
}
