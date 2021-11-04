resource "aws_lb_listener" "tuna" {
  load_balancer_arn = aws_lb.tuna.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "tuna" {
  listener_arn = aws_lb_listener.tuna.arn
  # target group간의 priority 조정가능
  priority     = 100
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tuna.arn
  }

  #   # 여러 target group 사용할때 forward 블록 사용
  # action {
  #   type = "forward"
  #   forward {
  #     target_group {
  #       arn    = aws_lb_target_group.tuna.arn
  #       weight = 100
  #     }
  #   #   target_group {
  #   #     arn    = aws_lb_target_group.canary.arn
  #   #     weight = 20
  #   #   }
  #     # stickiness {
  #     #   enabled  = true
  #     #   duration = 600
  #     # }
  #   }
  # }

  # condition {
  #   host_header {
  #     values = ["my-service.*.terraform.io"]
  #   }
  # }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
