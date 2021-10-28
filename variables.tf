variable "TF_VAR_instance_type" {
  description = "Value of the EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "TF_VAR_instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "aws_region" {
  description = "Value of aws default region"
  type        = string
  default     = "us-east-2"
}

variable "aws_profile" {
  description = "Value of aws profile"
  type        = string
  default     = "default"
}
