#creating output variable

output "public_ip" {
  value = [aws_instance.app_server[*]]
}