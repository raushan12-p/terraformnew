output "publicp" {
  value = aws_instance.dev.public_ip
  description = "printing public ip"
}
output "privateip" {
  value = aws_instance.dev.public_ip
  sensitive = true
}