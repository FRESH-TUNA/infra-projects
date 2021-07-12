resource "aws_internet_gateway" "scenario_6" {
  vpc_id = aws_vpc.scenario_6.id

  tags = {
    Name = "main"
  }
}
