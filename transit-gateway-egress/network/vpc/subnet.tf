# subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.networking.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.networking.id
  cidr_block = "172.16.0.16/28"
  availability_zone = "ap-northeast-2a"
}
