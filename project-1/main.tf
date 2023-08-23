

#create a VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
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

# create key-pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "myec2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDToQ/L39VTU7sTDU8ojxDaIvTa/UJlrBq6sqKJYrQcKgFdPzUPoOBBvtHCViRhgYVrBxocLV8tnochESW4UCTi1SpW8ckGmMKhvrRWPUZ2p7DzBz9E6kN8Z6NZhdjHxck+MIplOzuQv0QdZBm+bBfpHSP6rfyiSoPbk4hgaemIfD4WEkvBF5UhF15AZIcNqE7oulMXB/zp4BPTdJhxZAENM/O12nqedKvggW1ybbwk6Sg54YSqEIp1YzrUqYaU00dh38/lB5aVnpbavkyaAt7k3F5H9Vr398xueQJgYlfQOoQh0Eh/nyMLymV/AgHmYDrQz97gMAM4BWKjfEU3EmzHZFVxMb8pMcR3D1OR6Y2q3JAT6rbTEKQIgIzDy97BKpT9KJxZyq2wge43yJ5D+yp0TkPZmCu2YRfnOScyKntS2QtCI2kot0kRBvno2m3zjM28c9Y4+m80DzCy4cAwNmOS4jRoMp/5kyjSJ61Bb5iwybWoahrhJxaEYarZMlPUMEM= ubuntu@ip-172-31-13-62"
}

# Create EC2 instance the vpc_security_group_ids is refrence from the security resource, the subnet_id is refrence from the vpc module where [0] represent the first string of the public_subnet list. 
#To enable public IP, we enable subnet_id to true.
resource "aws_instance" "app_server" {
  ami           = "ami-0f8e81a3da6e2510a"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name      = aws_key_pair.ec2_key.key_name
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = true
 for_each = {
    k8s-control = "Instance-1"
    k8s-worker1= "Instance-2"
    k8s-worker2 = "Instance-3"
  }
 tags = {
    Name = each.key
    Numbering = each.value
  }
}