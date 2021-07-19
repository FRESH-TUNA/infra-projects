resource "aws_internet_gateway" "client" {
  vpc_id = aws_vpc.client.id

  tags = {
    Name = "main"
  }
}
