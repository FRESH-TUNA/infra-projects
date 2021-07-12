resource "aws_ssm_parameter" "app_envs" {
  name        = "/scenario_6/app"
  description = "app credential"
  type        = "SecureString"
  value       = templatefile("${path.module}/app.env.mock", 
  { 
    AWS_DEFAULT_REGION = var.AWS_DEFAULT_REGION,
    AWS_STORAGE_BUCKET_NAME = var.AWS_STORAGE_BUCKET_NAME,
    ALLOWED_HOST = "test.freshtuna.me",

    SECRET_KEY = var.SECRET_KEY,
    DB_HOST = var.DB_HOST,
    DB_NAME = var.DB_NAME,
    DB_USER = var.DB_USER,
    DB_PASSWORD = var.DB_PASSWORD,
    DB_PORT = var.DB_PORT,

    CLOUDFRONT_URL = var.CLOUDFRONT_URL,
    CLOUDFRONT_PRIVATE_KEY = var.CLOUDFRONT_PRIVATE_KEY,
    CLOUDFRONT_KEY_PAIR_ID = var.CLOUDFRONT_KEY_PAIR_ID })

  tags = {
    environment = "production"
  }
}

resource "aws_ssm_parameter" "app_cloudfront_private_key" {
  name        = "/scenario_6/app/cloudfront_private_key"
  description = "app_envs_cloudfront_private_key"
  type        = "SecureString"
  value       = templatefile("${path.module}/app_cloudfront_private_key.env.mock", 
  { CLOUDFRONT_PRIVATE_KEY = var.CLOUDFRONT_PRIVATE_KEY })

  tags = {
    environment = "production"
  }
}
