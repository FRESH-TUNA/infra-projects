# data "aws_caller_identity" "accepter" {
#   provider = aws.accepter
# }

# # Requester's side of the connection.
# resource "aws_vpc_peering_connection" "requester" {
#   vpc_id        = aws_vpc.requester.id
#   peer_vpc_id   = aws_vpc.accepter.id
#   peer_owner_id = data.aws_caller_identity.accepter.account_id
#   peer_region   = "us-west-2"
#   auto_accept   = false

#   tags = {
#     Side = "Requester"
#   }
# }

# # Accepter's side of the connection.
# resource "aws_vpc_peering_connection_accepter" "accepter" {
#   provider                  = aws.accepter
#   vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
#   auto_accept               = true

#   tags = {
#     Side = "Accepter"
#   }
# }
