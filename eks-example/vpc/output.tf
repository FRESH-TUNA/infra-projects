output "id" {
  value = aws_vpc.eks.id
}

output "cluster_public_subnet_ids" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
    aws_subnet.public_3.id
  ]
}

output "cluster_private_subnet_ids" {
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
    aws_subnet.private_3.id
  ]
}

output "db_private_subnet_ids" {
  value = [
    aws_subnet.db_private_1.id,
    aws_subnet.db_private_2.id,
    aws_subnet.db_private_3.id
  ]
}

output "route_table_id" {
  value = aws_route_table.cluster_public.id
}
