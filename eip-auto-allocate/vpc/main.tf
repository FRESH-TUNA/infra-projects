# vpc
resource "aws_vpc" "scenario_2" {
  cidr_block = "172.16.0.0/25"
  tags = {
    Name = "scenario_2_vpc"
  }
}
