# vpc
resource "aws_vpc" "scenario_2" {
  cidr_block = "172.16.0.0/25"
  tags = {
    Environment = "auto_scaling_group_target_track"
  }
}
