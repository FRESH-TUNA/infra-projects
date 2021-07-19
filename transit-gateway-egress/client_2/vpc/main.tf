# vpc
resource "aws_vpc" "client" {
  cidr_block = "172.16.0.64/27"
}
