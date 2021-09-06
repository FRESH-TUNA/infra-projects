resource "aws_iam_openid_connect_provider" "tuna-eks-cluster" {
  url = var.oidc_provider_issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [var.oidc_provider_thumbprint]
}
