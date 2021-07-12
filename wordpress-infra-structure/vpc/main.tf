# vpc
resource "aws_vpc" "scenario_5" {
  cidr_block = "172.16.0.0/24"
  tags = {
    Name = "scenario_5_vpc"
  }
}
