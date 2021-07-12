output "app_envs_arn" {
    value = aws_ssm_parameter.app_envs.arn
}

output "app_envs_path" {
    value = aws_ssm_parameter.app_envs.name
}

output "app_cloudfront_private_key_env_path" {
    value = aws_ssm_parameter.app_cloudfront_private_key.name
}
