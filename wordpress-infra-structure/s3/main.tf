resource "aws_s3_bucket" "s3" {
  bucket = "logs"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "scenario_5" {
  bucket = "scenario_5"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
