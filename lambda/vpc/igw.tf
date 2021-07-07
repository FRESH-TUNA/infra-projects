resource "aws_internet_gateway" "knufesta2019" {
  vpc_id = aws_vpc.knufesta2019.id

  tags = {
    Name = "main"
  }
}
