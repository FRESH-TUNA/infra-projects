resource "aws_eks_cluster" "cluster" {
  name     = "eks_cluster"
  role_arn = var.luster_role_arn

  vpc_config {
    subnet_ids = var.cluster_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = var.cluster_role_attachments
}
