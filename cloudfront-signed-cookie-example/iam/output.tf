output "instance_profile_name" {
  value = aws_iam_instance_profile.app.name
}

output "app_role_id" {
  value = aws_iam_role.app.arn
}
