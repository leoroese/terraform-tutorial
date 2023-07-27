#Creating an input variable
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "azs" {
  type = list(any)
  default = [ "The availaibility zones for the VPC module" ]
}

