resource "aws_nat_gateway" "public" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id
}
