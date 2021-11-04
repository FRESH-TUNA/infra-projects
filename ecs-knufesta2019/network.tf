resource "aws_vpc" "knufesta2019" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_internet_gateway" "knufesta2019" {
  vpc_id = aws_vpc.knufesta2019.id

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_subnet" "database" {
  vpc_id            = aws_vpc.knufesta2019.id
  count             = length(var.database_subnets)
  cidr_block        = element(var.database_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.knufesta2019.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.knufesta2019.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.knufesta2019.id

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.knufesta2019.id

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.knufesta2019.id
}

resource "aws_vpc_endpoint_route_table_association" "private" {
  route_table_id  = aws_route_table.private.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
