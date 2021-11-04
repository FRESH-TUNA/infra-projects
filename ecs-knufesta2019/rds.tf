resource "aws_db_subnet_group" "knufesta2019" {
  name       = "knufesta2019"
  subnet_ids = aws_subnet.database.*.id
}

resource "aws_rds_cluster" "knufesta2019" {
  cluster_identifier = "knufesta2019"
  database_name      = var.DB_NAME
  master_username    = var.DB_USER
  master_password    = var.DB_PASSWORD
  engine             = "aurora-postgresql"
  db_subnet_group_name = aws_db_subnet_group.knufesta2019.name
  vpc_security_group_ids = [aws_security_group.knufesta2019_database.id]
  skip_final_snapshot  = true
}

resource "aws_rds_cluster_instance" "knufesta2019" {
  count              = 1
  identifier         = "knufesta2019-${count.index}"
  cluster_identifier = aws_rds_cluster.knufesta2019.id
  engine             = "aurora-postgresql"
  instance_class     = "db.t3.medium"
}


resource "aws_security_group" "knufesta2019_database" {
  vpc_id = aws_vpc.knufesta2019.id

  ingress {
    from_port        = var.DB_PORT
    to_port          = var.DB_PORT
    protocol         = "tcp"
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
