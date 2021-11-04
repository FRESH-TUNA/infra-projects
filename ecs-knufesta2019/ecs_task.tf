# data "template_file" "env_vars" {
#   template = file("env_vars.json")
# }
resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "aws-ecs-task"
  cpu = 256
  memory = 256
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode = "bridge"
  #platformFamily = "LINUX"

  # container_definitions = jsonencode(
  # [ 
  #     { 
  #        "command": [
  #           "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
  #        ],
  #        "entryPoint": [
  #           "sh",
  #           "-c"
  #        ],
  #        "essential": true,
  #        "image": "httpd:2.4",
  #        "logConfiguration": { 
  #           "logDriver": "awslogs",
  #           "options": { 
  #              "awslogs-group" : "/ecs/knufesta2019",
  #              "awslogs-region": "ap-northeast-2",
  #              "awslogs-stream-prefix": "ecs"
  #           }
  #        },
  #        "name": "httpd",
  #        "portMappings": [ 
  #           { 
  #             "containerPort": 80,
  #             # dynamic port mapping
  #              "hostPort": 0,
  #              "protocol": "tcp"
  #           }
  #        ]
  #     }
  #  ])

  container_definitions = jsonencode(
  [ 
      { 
         "essential": true,
         "image": "840413533122.dkr.ecr.ap-northeast-2.amazonaws.com/knufesta2019:3.0.0",
         "logConfiguration": { 
            "logDriver": "awslogs",
            "options": { 
               "awslogs-group" : "/ecs/knufesta2019",
               "awslogs-region": "ap-northeast-2",
               "awslogs-stream-prefix": "ecs"
            }
         },
         "environment": [
           {
            "name": "DB_NAME",
            "value": "${var.DB_NAME}"
           },
           {
            "name": "DB_USER",
            "value": "${var.DB_USER}"
           },
           {
            "name": "DB_PASSWORD",
            "value": "${var.DB_PASSWORD}"
           },
           {
            "name": "DB_HOST",
            "value": "${aws_rds_cluster.knufesta2019.endpoint}"
           },
           {
            "name": "DB_PORT",
            "value": "${var.DB_PORT}"
           },
           {
            "name": "ALLOWED_HOSTS",
            "value": "${aws_alb.application_load_balancer.dns_name}"
           },
           {
            "name": "AWS_STORAGE_BUCKET_NAME",
            "value": "knufesta2019"
           },
           {
            "name": "AWS_REGION",
            "value": "${var.aws_region}"
           },
           {
            "name": "SECRET_KEY",
            "value": "${var.SECRET_KEY}"
           }
          ],
         "name": "knufesta2019",
         "portMappings": [ 
            { 
              "containerPort": 80,
              # dynamic port mapping
               "hostPort": 0,
               "protocol": "tcp"
            }
         ]
      }
   ])
}

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

# resource "aws_security_group" "service_security_group" {
#   vpc_id = aws_vpc.knufesta2019.id

#   ingress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.load_balancer_security_group.id]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name        = "${var.app_name}"
#     Environment = var.app_environment
#   }
# }



#ecsTaskExecutionRole
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.app_name}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
