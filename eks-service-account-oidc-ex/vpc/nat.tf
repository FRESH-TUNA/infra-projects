resource "aws_nat_gateway" "public_1" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id
}
