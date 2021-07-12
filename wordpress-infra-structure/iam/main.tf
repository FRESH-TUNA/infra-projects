resource "aws_iam_role" "asg" {
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

resource "aws_iam_role_policy_attachment" "asg_ec2_associate_elasticip" {
  role       = aws_iam_role.asg.name
  policy_arn = aws_iam_policy.ec2_associate_elasticip.arn
}

resource "aws_iam_instance_profile" "asg" {
  name = "asg_logic_associate_elasticip"
  role = aws_iam_role.asg.name
}
