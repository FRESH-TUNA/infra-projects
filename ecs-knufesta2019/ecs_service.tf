resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${var.app_name}-${var.app_environment}-ecs-service"
  cluster              = aws_ecs_cluster.knufesta2019.id
  task_definition      = aws_ecs_task_definition.aws-ecs-task.arn
#   launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  force_new_deployment = true

  # network_configuration {
  #   subnets          = aws_subnet.public.*.id
  #   # assign_public_ip = false
  #   security_groups = [
  #     aws_security_group.service_security_group.id,
  #     aws_security_group.load_balancer_security_group.id
  #   ]
  # }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.knufesta2019.name
    weight = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "knufesta2019"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]
}
