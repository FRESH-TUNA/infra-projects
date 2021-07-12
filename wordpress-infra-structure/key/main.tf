resource "aws_key_pair" "logic" {
  key_name = "scenario_1_ec2_logic"
  public_key = file("~/.ssh/scenario_1_ec2_logic.pub")
}
