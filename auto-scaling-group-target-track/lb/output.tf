output "id" {
  value = aws_lb.tuna.id
}

output "tuna_target_group_arn" {
  value = aws_lb_target_group.tuna.arn
}
