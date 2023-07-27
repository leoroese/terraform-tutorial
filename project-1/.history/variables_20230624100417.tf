#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(string)
  default = [ "us-east-2a", "us-east-2b", "us-east-2c" ]
}

locals {
  Name = "My-Test-Instance"
  Method = "terraform"
}