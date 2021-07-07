# vpc
resource "aws_vpc" "knufesta2019" {
  cidr_block = "172.16.0.0/25"
  tags = {
    Name = "knufesta2019_vpc"
  }
}
