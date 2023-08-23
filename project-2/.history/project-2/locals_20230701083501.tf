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

# Use locals to grab the decrypted secret from secrets manager
locals {
  db_cred = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}
