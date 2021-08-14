terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = ">= 3.50.0"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_ssm_parameter" "app_envs" {
  name        = "/scenario_6/app"
  description = "app credential"
  type        = "SecureString"
  value       = templatefile("${path.module}/app.env.mock", 
  { 
    CLOUDFRONT_URL = var.CLOUDFRONT_URL,
    CLOUDFRONT_PRIVATE_KEY = var.CLOUDFRONT_PRIVATE_KEY})

  tags = {
    environment = "production"
  }
}
