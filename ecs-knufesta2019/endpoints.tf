resource "aws_security_group" "endpoint" {
  vpc_id = aws_vpc.knufesta2019.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.instance_balancer_security_group.id]
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


resource "aws_vpc_endpoint" "ecs" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.ecs"
  vpc_endpoint_type = "Interface"

  subnet_ids          = aws_subnet.private.*.id
  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-agent" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.ecs-agent"
  vpc_endpoint_type = "Interface"

  subnet_ids          = aws_subnet.private.*.id
  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecs-telemetry" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.ecs-telemetry"
  vpc_endpoint_type = "Interface"

  subnet_ids          = aws_subnet.private.*.id
  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
  subnet_ids          = aws_subnet.private.*.id
  private_dns_enabled = true
}

resource "aws_security_group" "ecr_endpoint" {
  vpc_id = aws_vpc.knufesta2019.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.private_subnets
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

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.s3"
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = aws_vpc.knufesta2019.id
  service_name      = "com.amazonaws.ap-northeast-2.logs"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true
  subnet_ids          = aws_subnet.private.*.id
  security_group_ids = [
    aws_security_group.endpoint.id,
  ]
}
