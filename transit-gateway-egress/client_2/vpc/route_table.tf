resource "aws_route_table" "private" {
  vpc_id = aws_vpc.client.id

   route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = var.shared_tgw_arn
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.client.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.client.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
