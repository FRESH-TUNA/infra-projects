resource "aws_internet_gateway" "scenario_5" {
  vpc_id = aws_vpc.scenario_5.id

  tags = {
    Name = "main"
  }
}
