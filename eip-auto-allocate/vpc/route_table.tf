# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.scenario_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scenario_2.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.scenario_2.id

  tags = {
    Name = "main"
  }
}

# route table association
resource "aws_route_table_association" "scenario_2_public_1" {
  subnet_id      = aws_subnet.scenario_2_public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "scenario_2_public_2" {
  subnet_id      = aws_subnet.scenario_2_public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "scenario_2_public_3" {
  subnet_id      = aws_subnet.scenario_2_public_3.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "scenario_2_private_1" {
  subnet_id      = aws_subnet.scenario_2_private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "scenario_2_private_2" {
  subnet_id      = aws_subnet.scenario_2_private_2.id
  route_table_id = aws_route_table.private.id
}
