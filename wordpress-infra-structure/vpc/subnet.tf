# subnet
resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "scenario_2_public_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.0.16/28"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "scenario_2_public_2"
  }
}

resource "aws_subnet" "app_1" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.0.32/20"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "app_1"
  }
}

resource "aws_subnet" "app_2" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.2.32/20"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "app_2"
  }
}

resource "aws_subnet" "data_1" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.4.32/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "data_1"
  }
}

resource "aws_subnet" "data_2" {
  vpc_id = aws_vpc.scenario_5.id
  cidr_block = "172.16.5.32/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "data_2"
  }
}
