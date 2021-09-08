resource "aws_lb_target_group" "tuna" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.tuna.id
  alb_target_group_arn   = aws_lb_target_group.tuna.arn
}
