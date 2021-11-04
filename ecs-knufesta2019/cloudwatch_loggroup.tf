resource "aws_cloudwatch_log_group" "knufesta2019" {
  name = "/ecs/knufesta2019"

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}
