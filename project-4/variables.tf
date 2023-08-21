variable "instance_type" {
  type = string
  default = "t2.large"
}

variable "azs" {
  type = list(string)
  default = [ "us-west-1b", "us-west-1c" ]
}
