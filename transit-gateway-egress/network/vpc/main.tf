# vpc
resource "aws_vpc" "networking" {
  cidr_block = "172.16.0.0/27"
  tags = {
    Name = "vpc-peering-accepter"
  }
}
