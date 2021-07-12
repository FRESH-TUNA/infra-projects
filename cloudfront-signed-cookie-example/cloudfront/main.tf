resource "aws_cloudfront_public_key" "scenario_6" {
  comment     = "test public key"
  encoded_key = var.cloudfront_public_key
  name        = "test_key"
}

resource "aws_cloudfront_distribution" "scenario_6" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "app_s3"

    s3_origin_config {
      origin_access_identity = var.app_cloudfront_access_identity_path
    }
  }
  enabled             = true
  comment             = "scenario_6"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "app_s3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
