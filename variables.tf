
#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(string)
  default = [ "us-east-2a", "us-east-2b", "us-east-2c" ]
}

/*variable "aws_region" {
  description = "Value of aws default region"
  type        = string
  default     = "us-east-2"
}

variable "aws_profile" {
  description = "Value of aws profile"
  type        = string
  default     = "Terraform"
}*/