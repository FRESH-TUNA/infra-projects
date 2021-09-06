resource "aws_internet_gateway" "eks" {
  vpc_id = aws_vpc.tuna-infra.id

  tags = {
    Name = "main"
  }
}
