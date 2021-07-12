# subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.scenario_4.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "scenario_4_public"
  }
}

# subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.scenario_4.id
  cidr_block = "172.16.0.16/28"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "scenario_4_private"
  }
}
