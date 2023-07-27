#Create a Local Variables for ingress
locals { 
    inbound_rules = [
    {
  description = "SSH From VPC"
  port = 22
  cidr_block = ["0.0.0.0/0"]
},
{ description = "HTTP from internet"
  port = 80
  cidr_block = ["0.0.0.0/0"]
},
{ description = "sonarqube Port"
  port = "9000"
  cidr_block = ["0.0.0.0/0"]
}
]
}
