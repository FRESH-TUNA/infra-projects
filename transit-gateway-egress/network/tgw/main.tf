#Create Transit Gateway
resource "aws_ec2_transit_gateway" "networking" {
  description = "Transit Gateway"
  auto_accept_shared_attachments = "enable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "networking" {
  vpc_id             = var.vpc_id                  #서브넷이 위치하는 VPC
  subnet_ids         = var.subnets#TGW에 붙을 서브넷
  transit_gateway_id = aws_ec2_transit_gateway.networking.id #붙을 대상이되는 TGW
  tags = {
      Name = "test-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_route" "egress" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.networking.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.networking.association_default_route_table_id
}
