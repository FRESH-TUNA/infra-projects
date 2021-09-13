resource "aws_autoscaling_group" "logic" {
  name                      = "logic"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  
  target_group_arns = var.logic_target_group_arns
  
  launch_template {
    id      = var.aws_launch_template_id
    version = "$Latest"
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
    }
    # triggers = ["tag"]
  }
}
