# # subnet
# resource "aws_subnet" "requester" {
#   vpc_id = aws_vpc.requester.id
#   cidr_block = "172.16.0.0/28"
#   availability_zone = "ap-northeast-2a"
#   tags = {
#     Name = "private"
#   }
# }

# resource "aws_subnet" "accepter" {
#   provider = aws.accepter
#   vpc_id = aws_vpc.accepter.id
#   cidr_block = "172.16.0.32/28"
#   availability_zone = "us-west-2a"
#   tags = {
#     Name = "private"
#   }
# }
