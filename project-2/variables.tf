#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(any)
  default = [ "use2-az1", "use2-az2", "use2-az3" ]
}

