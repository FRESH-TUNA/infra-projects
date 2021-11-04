# 
resource "aws_autoscaling_policy" "logic_up" {
  # ... other configuration ...
  name = "logic_up"
  policy_type = "StepScaling"
  
  # only in simple and step
  # ChangeInCapacity, ExactCapacity, PercentChangeInCapacity
  adjustment_type = "ChangeInCapacity"
  
  # only in simplescaling
  # A scaling-specific cooldown period overrides the default cooldown period
  # cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.logic.name
  
  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0.0
    metric_interval_upper_bound = 10.0
  }

  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = 10.0
  }
}

resource "aws_autoscaling_policy" "logic_down" {
  # ... other configuration ...
  name = "logic_down"
  policy_type = "StepScaling"
  
  # only in simple and step
  # ChangeInCapacity, ExactCapacity, PercentChangeInCapacity
  adjustment_type = "ChangeInCapacity"
  
  # only in simplescaling
  # cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.logic.name
  
  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = -9
    metric_interval_upper_bound = 0
  }

  step_adjustment {
    scaling_adjustment          =  -2
    metric_interval_upper_bound = -9.0
  }
}
