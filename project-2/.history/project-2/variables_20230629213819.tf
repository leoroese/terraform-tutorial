#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(string)
  default = [ "us-east-2a", "us-east-2b", "us-east-2c" ]
}

#Create a Local Variables for ingress
locals "rules" {
  description = "SSH From VPC"
  cidr_block = ["0.0.0.0/0"]
}

locals "http" {
  description = "HTTP from internet"
  cidr_block = ["0.0.0.0/0"]
}