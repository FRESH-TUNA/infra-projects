output "cluster_arn" {
  value = aws_iam_role.cluster.arn
}

output "node_group_arn" {
  value = aws_iam_role.node_group.arn
}
