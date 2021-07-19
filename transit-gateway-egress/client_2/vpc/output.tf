output "id" {
  value = aws_vpc.client.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}
