# vpc
resource "aws_vpc" "scenario_6" {
  cidr_block = "172.16.0.0/25"
  tags = {
    Name = "scenario_6_vpc"
  }
}
