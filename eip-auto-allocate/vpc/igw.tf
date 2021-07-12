resource "aws_internet_gateway" "scenario_2" {
  vpc_id = aws_vpc.scenario_2.id

  tags = {
    Name = "main"
  }
}
