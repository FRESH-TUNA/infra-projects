# subnet
resource "aws_subnet" "scenario_2_public_1" {
  vpc_id = aws_vpc.scenario_2.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "scenario_2_public_1"
  }
}

resource "aws_subnet" "scenario_2_public_2" {
  vpc_id = aws_vpc.scenario_2.id
  cidr_block = "172.16.0.16/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "scenario_2_public_2"
  }
}

resource "aws_subnet" "scenario_2_public_3" {
  vpc_id = aws_vpc.scenario_2.id
  cidr_block = "172.16.0.32/28"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "scenario_2_public_3"
  }
}

resource "aws_subnet" "scenario_2_private_1" {
  vpc_id = aws_vpc.scenario_2.id
  cidr_block = "172.16.0.48/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "scenario_2_private_1"
  }
}

resource "aws_subnet" "scenario_2_private_2" {
  vpc_id = aws_vpc.scenario_2.id
  cidr_block = "172.16.0.64/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "scenario_2_private_2"
  }
}
