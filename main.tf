terraform {
  # backend "remote" {
  #   organization = "documentation-nerds"
  #   workspaces {
  #     name = "terraform-tutorial"
  #   }
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.9"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.test_role.name
  policy = jsonencode({
    "Statement" = [{
      # This policy allows software running on the EC2 instance to
      # access the S3 API.
      "Action" = "s3:*",
      "Effect" = "Allow",
    }],
  })
}

resource "aws_instance" "app_server" {
  ami           = "ami-074cce78125f09d61"
  instance_type = var.TF_VAR_instance_type

  tags = {
    Name = var.TF_VAR_instance_name
  }

  depends_on = [
    aws_iam_role_policy.example
  ]
}
