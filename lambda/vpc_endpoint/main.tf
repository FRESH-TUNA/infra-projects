resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_private" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id = var.route_table_id
}
