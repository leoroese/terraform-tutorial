# Use data source to refrence VPC
data "aws_vpc" "prod" {
  id = "vpc-03b9b2becaa11528b"
}

# Use data source to reference user-data file
data "template_file" "user_data" {
  template = file("./nginx-install.yaml")
}
# Define local values
locals {
  instance_name = "My-TF-Linux"
  environment   = "tf"
}

# Create a security group
resource "aws_security_group" "sg_terraform" {
  name        = "terraform-sg"
  description = "Allow HTTP From Internet"
  vpc_id      = data.aws_vpc.prod.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create key-pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "myec2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMYmboPcpK2Pk3CD+9kMTqMJqKVnoN1hL1zQDsUnAg5L5nDIoB/6/8uTG+DctMfOz2M2iUNWxNhQPv11GYbf1mXo7OTz6tZ0S1z9xM/tV/jfxVBJhNS4OldPWxxOAfc2C7b4Wki1v5NZVpebk3fGOHE4krboZNesQkDOLy0dM2ewX1j587fhS22CQZIpnRHPLc9vYQHQ4uHilLEa3GN8I0UmkPT+RwSeWthqL+srM9s12vsyVi8X3QJD/2xO7DIbYFYsKhLE100CSWeKMMWN2USszfuIEUWo1SS8+WNbWGF6Q2OAfWYqaB5vRhxCE5yQ4bBOsvoYwoAQ9iS0OqxEd5UB3XbYCQD7cysguSHq3dlrgVc2HRY9SuxApiLe61ywCkx+mzMW3jHRQYbbYTxYLRVZcPebR3Oc7FR8XFDmtU7RAt8uTVGu8j73a9V4Gp8WLEZVi7Op3Tp4JjovVkyZ99QalzHHZvVhnUZgiZbWUrabnTWIglTgrDs2QCFZQ3Zmk= njinko@HerbertPC"
}
# Create EC2 instance
resource "aws_instance" "web_server" {
  ami                    = "ami-06ca3ca175f37dd66"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.sg_terraform.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "${local.instance_name} Web Server "
  }

}

