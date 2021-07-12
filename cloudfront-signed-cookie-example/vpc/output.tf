output "id" {
  value = aws_vpc.scenario_6.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.scenario_6_public_1.id,
    aws_subnet.scenario_6_public_2.id,
    aws_subnet.scenario_6_public_3.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.scenario_6_private_1.id,
    aws_subnet.scenario_6_private_2.id,
  ]
}
