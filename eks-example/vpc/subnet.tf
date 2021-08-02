# subnet
resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.16/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_3" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.32/28"
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
  cidr_block = "172.16.0.48/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.64/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_3" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.80/28"
  availability_zone = "ap-northeast-2c"
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# private subnet
resource "aws_subnet" "db_private_1" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.96/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "private_1"
  }
}

resource "aws_subnet" "db_private_2" {
  vpc_id = aws_vpc.eks.id
  cidr_block = "172.16.0.112/28"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name = "private_2"
  }
}

# resource "aws_subnet" "db_private_3" {
#   vpc_id = aws_vpc.eks.id
#   cidr_block = "172.16.0.128/28"
#   availability_zone = "ap-northeast-2c"
#   tags = {
#     Name = "private_3"
#   }
# }
