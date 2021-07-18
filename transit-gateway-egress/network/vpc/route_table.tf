# route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.networking.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.networking.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.networking.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gateway_id
  }

  route {
    cidr_block = var.client_1_cidr
    transit_gateway_id = var.transit_gateway_id
  }
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
