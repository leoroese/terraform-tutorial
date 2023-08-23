# Create VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"


  name = "NewEraVPC"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create Public Subnet
resource "aws_subnet" "pub_sub" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.104.0/24"

}

# Create an EC2 instance
resource "aws_instance" "web_server" {
  #ami = data.aws_ami.amzn.id
  ami = "ami-03f38e546e3dc59e1"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id =   aws_subnet.pub_sub.id
  associate_public_ip_address = true
  for_each = {
    Naomie = "Instance-1"
    Cally = "Instance-2"
    Lizzy = "Instance-3"
  }

  tags = {
    Name = each.key
    Numbering = each.value
  }

  lifecycle {
    create_before_destroy = true
}
}

# Create Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = local.inbound_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_block
    }
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

  # depends_on = [ data.aws_ami.amzn ]
}

# Create Data Source
/*data "aws_ami" "amzn" {
  id = "ami-06b09bfacae1453cb"
}*/

# Create RDS Instance
resource "aws_db_instance" "db_group" { 

  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_group.name

  depends_on = [
    aws_security_group.my_sg
  ]

  lifecycle {
    replace_triggered_by = [ aws_instance.web_server ]
  }
}

resource "aws_db_subnet_group" "db_group" {
  name       = "rds-subnet-group"  
  subnet_ids = flatten([module.vpc.private_subnets])  
  tags = {    Environment = "prod"  }
  }