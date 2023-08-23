#Create a Local Variables for ingress
locals { 
    inbound_rules = [
    {
  description = "SSH From VPC"
  port = 22
  subnet= ["0.0.0.0/0"]
},
{ description = "HTTP from internet"
  PORT = 80
  subnet = ["0.0.0.0/0"]
}
]
}
