####
# for tuna-eks-cluster service accounts (oidc)
data "aws_iam_policy_document" "tuna-eks-cluster_autoscaler" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.tuna-eks-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.tuna-eks-cluster.arn]
      type        = "Federated"
    }
  }
}


resource "aws_iam_policy" "tuna-eks-cluster_autoscaler" {
  name        = "tuna-eks-cluster_autoscaler"
  description = "tuna-eks-cluster_autoscaler_policy"

  policy = file("${path.module}/cluster-autoscaler-policy.json")
}

resource "aws_iam_role" "tuna-eks-cluster_autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.tuna-eks-cluster_autoscaler.json
  name               = "tuna-eks-cluster_autoscaler"
}

resource "aws_iam_role_policy_attachment" "tuna-eks-cluster_autoscaler" {
  policy_arn = aws_iam_policy.tuna-eks-cluster_autoscaler.arn
  role       = aws_iam_role.tuna-eks-cluster_autoscaler.name
}
