resource "aws_internet_gateway" "scenario_4" {
  vpc_id = aws_vpc.scenario_4.id

  tags = {
    Name = "main"
  }
}
