output "allocation_id" {
  value = aws_eip.app.id
}

output "app_ip_address" {
  value = aws_eip.app.public_ip
}
