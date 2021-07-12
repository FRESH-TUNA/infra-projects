output "app_iam_arn" {
    value = aws_cloudfront_origin_access_identity.scenario_6.iam_arn
}

output "app_cloudfront_access_identity_path" {
    value = aws_cloudfront_origin_access_identity.scenario_6.cloudfront_access_identity_path
}
