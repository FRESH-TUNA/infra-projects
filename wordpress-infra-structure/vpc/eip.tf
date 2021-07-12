resource "aws_eip" "public_1_nat_gateway" {
  vpc      = true
}

resource "aws_eip" "public_2_nat_gateway" {
  vpc      = true
}
