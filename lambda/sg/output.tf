output "database_id" {
    value = aws_security_group.database.id
}

output "front_id" {
    value = aws_security_group.front.id
}
