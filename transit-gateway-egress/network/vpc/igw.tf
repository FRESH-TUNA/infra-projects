resource "aws_internet_gateway" "networking" {
  vpc_id = aws_vpc.networking.id

  tags = {
    Name = "main"
  }
}
