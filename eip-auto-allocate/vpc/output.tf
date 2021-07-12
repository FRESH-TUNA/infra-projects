output "id" {
  value = aws_vpc.scenario_2.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.scenario_2_public_1.id,
    aws_subnet.scenario_2_public_2.id,
    aws_subnet.scenario_2_public_3.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.scenario_2_private_1.id,
    aws_subnet.scenario_2_private_2.id,
  ]
}
