resource "aws_ecs_capacity_provider" "knufesta2019" {
  name = "knufesta2019"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.knufesta2019.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 100
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_key_pair" "knufesta2019" {
  key_name = "knufesta2019"
  public_key = file("${path.module}/freshtuna.pub")
}


resource "aws_autoscaling_group" "knufesta2019" {
  # ... other configuration, including potentially other tags ...
  min_size = 0
  desired_capacity = 0
  max_size = 2
  protect_from_scale_in = true
  vpc_zone_identifier = aws_subnet.private.*.id

  launch_template {
    id      = aws_launch_template.knufesta2019.id
    version = "$Latest"
  }
  
  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "knufesta2019" {
  name_prefix   = "knufesta2019"
  image_id      = "ami-058fe05d80d934d8a"
  instance_type = "t2.micro"

  user_data = base64encode(templatefile("${path.module}/user_data.sh",
    { CLUSTER_NAME = "${var.app_name}-${var.app_environment}" }))

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile_for_ecs.arn
  }

  key_name = aws_key_pair.knufesta2019.key_name

  vpc_security_group_ids = [aws_security_group.instance_balancer_security_group.id]
}

resource "aws_security_group" "instance_balancer_security_group" {
  vpc_id = aws_vpc.knufesta2019.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}


#### iam instance profile
# iam.tf | IAM Role Policies
resource "aws_iam_role" "ecsInstanceRole" {
  name               = "${var.app_name}-ecsInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.ecsInstanceRole-assume_role_policy.json
  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

data "aws_iam_policy_document" "ecsInstanceRole-assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com", "ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsInstanceRole" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "instance_profile_for_ecs" {
  name = "instance_profile_for_ecs"
  role = aws_iam_role.ecsInstanceRole.name
}
