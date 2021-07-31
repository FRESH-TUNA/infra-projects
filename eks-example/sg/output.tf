output "cluster_id" {
  value = aws_security_group.cluster.id
}

output "node_group_id" {
  value = aws_security_group.node_group.id
}
