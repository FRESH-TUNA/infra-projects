# vpc
resource "aws_vpc" "scenario_4" {
  cidr_block = "172.16.0.0/27"
  tags = {
    Name = "scenario_4_vpc"
  }
}
