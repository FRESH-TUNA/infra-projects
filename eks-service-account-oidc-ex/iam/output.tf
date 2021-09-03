output "cluster_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_group_arn" {
  value = aws_iam_role.node_group.arn
}

output "cluster_attachment_amazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.amazonEKSClusterPolicy
}

output "cluster_attachment_amazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.amazonEKSVPCResourceController
}

output "node_group_attachment_amazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.amazonEKSWorkerNodePolicy
}

output "node_group_attachment_amazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.amazonEKS_CNI_Policy
}

output "node_group_attachment_amazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.amazonEC2ContainerRegistryReadOnly
}
