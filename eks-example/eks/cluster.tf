resource "aws_eks_cluster" "cluster" {
  name     = "eks_cluster"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.cluster_subnets
    security_group_ids = var.cluster_security_group_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.cluster_attachment_1,
    var.cluster_attachment_2
  ]
}
