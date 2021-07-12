output "app_domain_name" {
    value = aws_cloudfront_distribution.scenario_6.domain_name
}

output "app_key_pair_id" {
    value = aws_cloudfront_public_key.scenario_6.id
}
