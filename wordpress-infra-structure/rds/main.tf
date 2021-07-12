resource "aws_db_subnet_group" "app_db" {
  name        = "subnet_group"
  description = "Terraform example RDS subnet group"
  subnet_ids = var.data_subnet_ids
}

resource "aws_db_instance" "app_db" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.app_db.id
  engine               = "postgres"
  engine_version       = "11.5"
  identifier           = "app_db"
  instance_class       = "db.t2.micro"
  password             = "scenario_5_password"
  skip_final_snapshot  = true
  storage_encrypted    = false
  username             = "postgres"
  vpc_security_group_ids = [var.sg_id]
}

resource "aws_db_instance" "app_db_replica" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.app_db.id
  engine               = "postgres"
  engine_version       = "11.5"
  identifier           = "app_db"
  instance_class       = "db.t2.micro"
  password             = "scenario_5_password"
  skip_final_snapshot  = true
  storage_encrypted    = false
  username             = "postgres"
  vpc_security_group_ids = [var.sg_id]
  replicate_source_db = aws_db_instance.app_db.id
}
