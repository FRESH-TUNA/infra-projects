resource "aws_lb" "tuna" {
  name               = "tuna"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_sg_ids
  subnets            = var.lb_subnets

  # 삭제 방지
  enable_deletion_protection = false

  tags = {
    Environment = "auto_scaling_group_target_track"
  }
}
