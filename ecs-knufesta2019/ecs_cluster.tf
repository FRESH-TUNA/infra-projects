resource "aws_ecs_cluster" "knufesta2019" {
  name = "${var.app_name}-${var.app_environment}"
  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
  capacity_providers = [aws_ecs_capacity_provider.knufesta2019.name]
  # default_capacity_provider_strategy = aws_ecs_capacity_provider.knufesta2019.name
}
