resource "aws_iam_role" "app" {
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

resource "aws_iam_policy" "ec2_associate_elasticip" {
  name        = "associate_elasticip"
  description = "associate_elasticip"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ec2:AssociateAddress",
            "Resource": "*"
        },
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

resource "aws_iam_policy" "ssm_get_app_envs" {
  name        = "ssm_get_app_envs"
  description = "ssm_get_app_envs"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ssm:GetParameter",
            "Resource": "${var.app_envs_arn}*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "app_ec2_associate_elasticip" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.ec2_associate_elasticip.arn
}

resource "aws_iam_role_policy_attachment" "app_ssm_get_app_envs" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.ssm_get_app_envs.arn
}

resource "aws_iam_instance_profile" "app" {
  name = "asg_logic_associate_elasticip"
  role = aws_iam_role.app.name
}
