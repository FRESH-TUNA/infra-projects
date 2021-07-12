# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.scenario_5.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scenario_5.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.scenario_5.id

  tags = {
    Name = "main"
  }
}

# route table association
resource "aws_route_table_association" "public_public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.app_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.app_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_data_1" {
  subnet_id      = aws_subnet.data_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_data_2" {
  subnet_id      = aws_subnet.data_2.id
  route_table_id = aws_route_table.private.id
}
