resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"

  # trust policy
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "amazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}

####
# for tuna-eks-cluster service accounts (oidc)
data "aws_iam_policy_document" "example_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.tuna-eks-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.tuna-eks-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "ingress_policy" {
  name        = "ingress_policy"
  description = "ingress_policy"

  policy = file("${path.module}/ingress_policy.json")
}

resource "aws_iam_role" "ingress" {
  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
  name               = "ingress"
}

resource "aws_iam_role_policy_attachment" "ingress_policy" {
  policy_arn = aws_iam_policy.ingress_policy.arn
  role       = aws_iam_role.ingress.name
}
