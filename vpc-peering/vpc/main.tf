# # vpc
# resource "aws_vpc" "requester" {
#   cidr_block = "172.16.0.0/27"
#   tags = {
#     Name = "vpc-peering-requester"
#   }
# }


# # vpc
# resource "aws_vpc" "accepter" {
#   provider   = aws.accepter
#   cidr_block = "172.16.0.32/27"
#   tags = {
#     Name = "vpc-peering-accepter"
#   }
# }
