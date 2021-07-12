output "app_id" {
    value = aws_security_group.app.id
}

output "app_lb_id" {
    value = aws_security_group.app_lb.id
}

output "db_id" {
    value = aws_security_group.db.id
}

output "cache_id" {
    value = aws_security_group.cache.id
}
