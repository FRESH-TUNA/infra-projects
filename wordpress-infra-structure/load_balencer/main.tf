resource "aws_lb" "app" {
  name               = "app-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.app_sg_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  access_logs {
    bucket  = var.log_bucket_id
    prefix  = "aws_lb_app"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
