resource "aws_s3_bucket" "app" {
  bucket = "scenario6"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "app" {
  bucket = aws_s3_bucket.app.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.app_role_id}"
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.app.arn}",
        "${aws_s3_bucket.app.arn}/*"
      ]
    },
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.cloudfront_oai_app_iam_arn}"
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.app.arn}",
        "${aws_s3_bucket.app.arn}/*"
      ]
    }
  ]
}
POLICY
}
