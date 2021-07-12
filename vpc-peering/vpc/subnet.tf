# subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "private"
  }
}
