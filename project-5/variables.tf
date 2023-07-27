variable "instance_type" {
  description = "The capacity of the instance"
  type        = string
  default = "t2.micro"
  sensitive   = true
}

variable "azs" {
  type = list(any)
  default = [ "use2-az1", "use2-az2", "use2-az3" ]
}