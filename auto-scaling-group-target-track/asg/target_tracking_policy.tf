# Target Tracking Policy
# resource "aws_autoscaling_policy" "logic" {
#   name                   = "logic"
#   # scaling_adjustment     = 4
#   # adjustment_type        = "TargetTrackingScaling"
#   policy_type = "TargetTrackingScaling"
#   # only in simplescaling
#   # cooldown               = 30
#   autoscaling_group_name = aws_autoscaling_group.logic.name
  
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }

#     target_value = 5.0
#   }

#   # target_tracking_configuration {
#   #   customized_metric_specification {
#   #     metric_dimension {
#   #       name  = "fuga"
#   #       value = "fuga"
#   #     }

#   #     metric_name = "hoge"
#   #     namespace   = "hoge"
#   #     statistic   = "Average"
#   #   }

#   #   target_value = 40.0
#   # }
# }
