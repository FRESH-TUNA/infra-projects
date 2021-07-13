terraform {
  required_version = "1.0.2"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = var.REQUESTER_AWS_REGION
  access_key  = var.REQUESTER_AWS_ACCESS_KEY_ID
  secret_key  = var.REQUESTER_AWS_SECRET_ACCESS_KEY
}

provider "aws" {
  alias  = "accepter"
  region = var.ACCEPTER_AWS_REGION
  access_key  = var.ACCEPTER_AWS_ACCESS_KEY_ID
  secret_key  = var.ACCEPTER_AWS_SECRET_ACCESS_KEY
}

# vpc
resource "aws_vpc" "requester" {
  cidr_block = "172.16.0.0/27"
  tags = {
    Name = "vpc-peering-requester"
  }
}


# vpc
resource "aws_vpc" "accepter" {
  provider   = aws.accepter
  cidr_block = "172.16.0.32/27"
  tags = {
    Name = "vpc-peering-accepter"
  }
}

# subnet
resource "aws_subnet" "requester" {
  vpc_id = aws_vpc.requester.id
  cidr_block = "172.16.0.0/28"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "private"
  }
}

resource "aws_subnet" "accepter" {
  provider = aws.accepter
  vpc_id = aws_vpc.accepter.id
  cidr_block = "172.16.0.32/28"
  availability_zone = "us-west-2a"
  tags = {
    Name = "private"
  }
}

data "aws_caller_identity" "accepter" {
  provider = aws.accepter
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "requester" {
  vpc_id        = aws_vpc.requester.id
  peer_vpc_id   = aws_vpc.accepter.id
  peer_owner_id = data.aws_caller_identity.accepter.account_id
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

# route table
resource "aws_route_table" "requester" {
  vpc_id = aws_vpc.requester.id

  route {
    cidr_block = aws_vpc.accepter.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "requester" {
  subnet_id      = aws_subnet.requester.id
  route_table_id = aws_route_table.requester.id
}


resource "aws_route_table" "accepter" {
  vpc_id = aws_vpc.accepter.id
  provider = aws.accepter

  route {
    cidr_block = aws_vpc.requester.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "accepter" {
  provider = aws.accepter
  subnet_id      = aws_subnet.accepter.id
  route_table_id = aws_route_table.accepter.id
}
