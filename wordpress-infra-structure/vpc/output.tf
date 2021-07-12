output "id" {
  value = aws_vpc.scenario_5.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
  ]
}

output "app_subnet_ids" {
  value = [
    aws_subnet.app_1.id,
    aws_subnet.app_2.id,
  ]
}

output "data_subnet_ids" {
  value = [
    aws_subnet.data_1.id,
    aws_subnet.data_2.id,
  ]
}
