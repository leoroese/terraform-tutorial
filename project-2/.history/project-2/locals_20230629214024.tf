#Create a Local Variables for ingress
locals "rules" {
  description = "SSH From VPC"
  cidr_block = ["0.0.0.0/0"]
}

locals "http" {
  description = "HTTP from internet"
  cidr_block = ["0.0.0.0/0"]
}