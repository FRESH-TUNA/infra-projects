resource "aws_lb" "lb" {
  name               = "tuna-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.lb_subnets

  enable_deletion_protection = true

  tags = {
    Environment = "auto_scaling_group_target_track"
  }
}
