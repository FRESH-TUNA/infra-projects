resource "aws_ram_resource_share" "tgw" {
  name                      = "example"
  allow_external_principals = false
}

resource "aws_ram_resource_association" "tgw" {
  resource_arn       = var.tgw_arn
  resource_share_arn = aws_ram_resource_share.tgw.arn
}
