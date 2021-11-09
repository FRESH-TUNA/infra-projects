resource "aws_key_pair" "knufesta2019" {
  key_name = "knufesta2019"
  public_key = file("${path.module}/freshtuna.pub")
}
