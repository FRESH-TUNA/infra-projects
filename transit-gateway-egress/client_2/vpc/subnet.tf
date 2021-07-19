resource "aws_subnet" "private" {
  vpc_id = aws_vpc.client.id
  cidr_block = "172.16.0.64/28"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.client.id
  cidr_block = "172.16.0.80/28"
  availability_zone = "ap-northeast-2c"
}

