resource "aws_rds_cluster" "knufesta2019" {
  cluster_identifier = "knufesta2019"
  database_name      = "knufesta2019"
  master_username    = "knufesta2019"
  master_password    = "knufesta2019"
  engine             = "aurora-postgresql"
  engine_mode        = "serverless"
  vpc_security_group_ids = [var.sg_id]
}
