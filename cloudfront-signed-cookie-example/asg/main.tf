resource "aws_autoscaling_group" "logic" {
  name                      = "logic"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  
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
}
