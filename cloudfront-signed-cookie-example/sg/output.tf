output "app_id" {
    value = aws_security_group.app.id
}

output "database_id" {
    value = aws_security_group.database.id
}
