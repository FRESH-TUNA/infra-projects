resource "aws_nat_gateway" "public_1" {
  allocation_id = aws_eip.public_1_nat_gateway.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_nat_gateway" "public_2" {
  allocation_id = aws_eip.public_2_nat_gateway.id
  subnet_id     = aws_subnet.public_2.id

  tags = {
    Name = "gw NAT"
  }
}
