output "id" {
  value = aws_vpc.scenario_4.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
