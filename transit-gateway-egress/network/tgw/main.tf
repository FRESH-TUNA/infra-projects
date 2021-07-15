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
