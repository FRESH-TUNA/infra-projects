# # route table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.scenario_4.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     # gateway_id = aws_internet_gateway.scenario_4.id
#   }

#   tags = {
#     Name = "main"
#   }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }
