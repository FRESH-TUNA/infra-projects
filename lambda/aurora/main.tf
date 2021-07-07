resource "aws_db_subnet_group" "knufesta2019" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster" "knufesta2019" {
  cluster_identifier = "knufesta2019"
  database_name      = "knufesta2019"
  master_username    = "knufesta2019"
  master_password    = "knufesta2019"
  engine             = "aurora-postgresql"
  db_subnet_group_name = aws_db_subnet_group.knufesta2019.name
  vpc_security_group_ids = [var.sg_id]
}

resource "aws_rds_cluster_instance" "knufesta2019" {
  count              = 2
  identifier         = "knufesta2019-${count.index}"
  cluster_identifier = aws_rds_cluster.knufesta2019.id
  engine             = "aurora-postgresql"
  instance_class     = "db.t3.medium"
}