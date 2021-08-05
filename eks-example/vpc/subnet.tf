# subnet
resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.0/27"
  availability_zone = "ap-northeast-2a"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.32/27"
  availability_zone = "ap-northeast-2b"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_3" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.64/27"
  availability_zone = "ap-northeast-2c"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = true
}


# private subnet
resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.96/27"
  availability_zone = "ap-northeast-2a"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.128/27"
  availability_zone = "ap-northeast-2b"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_3" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.160/27"
  availability_zone = "ap-northeast-2c"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

# private subnet
resource "aws_subnet" "db_private_1" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.192/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "db_private_1"
  }
}

resource "aws_subnet" "db_private_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.208/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "db_private_2"
  }
}

resource "aws_subnet" "db_private_3" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.224/28"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "db_private_3"
  }
}
