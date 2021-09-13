output "logic_id" {
    value = aws_security_group.logic.id
}

output "lb_id" {
    value = aws_security_group.lb.id
}

output "nat_id" {
  value = aws_security_group.nat.id
}
