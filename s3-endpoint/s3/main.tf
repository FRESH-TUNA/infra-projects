resource "aws_s3_bucket" "scenario_4" {
  bucket = "scenario.4.bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "scenario_4" {
  bucket = aws_s3_bucket.scenario_4.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": ["${aws_s3_bucket.scenario_4.arn}/*",
                  "${aws_s3_bucket.scenario_4.arn}"],
      "Condition": {
        "StringEquals": {
          "aws:sourceVpce": "${var.aws_vpc_endpoint_id}"
        }
      }
    }
  ]
}
POLICY
}