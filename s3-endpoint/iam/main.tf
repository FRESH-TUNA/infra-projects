resource "aws_iam_role" "s3_access" {
  name = "asg_logic_associate_elasticip"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_access" {
  name        = "s3_access"
  description = "s3_access"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowStsDecode",
        "Effect": "Allow",
        "Action": "sts:DecodeAuthorizationMessage",
        "Resource": "*"
      }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.s3_access.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_instance_profile" "s3_access" {
  name = "s3_access"
  role = aws_iam_role.s3_access.name
}
