resource "aws_autoscaling_group" "logic" {
  name                      = "logic"
  max_size                  = 4
  min_size                  = 1

  # 새로운 인스턴스 시작후 health check 300초간 유예
  # 상태 확인으로 인해 인스턴스가 비정상으로 표시된 후에는 거의 즉시 교체가 예약
  health_check_grace_period = 300
  # EC2: auto scaling group 이 자체적으로 체크
  # ELB: ELB 체크 결과를 그대로 사용
  health_check_type         = "EC2"
  desired_capacity          = 1
  
  # cooldown settings
  #default_cooldown = 300
  # Cooldown is only supported by Simple policy. Target tracking and Step policies instead support warm-up period.
  #The concept is a bit different. With Cooldown, you need to wait an amount of time before another autoscaling event can happen. With warm-up, you need to wait before the new instances are considered into the target metric (which implies that another autoscaling event can happen in the meantime).
  target_group_arns = var.logic_target_group_arns
  
  # version을 직접 지정해야 refresh 활동 발생
  # $Latest 태그 refresh작동 안함
  launch_template {
    id      = var.aws_launch_template_id
    version = "1"
  }
  
  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "asg"
    value               = "test"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
  # terraform feature
  # By default, when Terraform must change a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead destroy the existing object and then create a new replacement object with the new configured arguments.
  #lifecycle {
  #  create_before_destroy = true
  #}

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 0

      # default is Auto Scaling Group's health check grace period.
      instance_warmup = 10
    }
    # triggers = ["tag"]
  }
}
