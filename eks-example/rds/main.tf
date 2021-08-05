resource "aws_db_subnet_group" "eks" {
  name        = "subnet_group"
  description = "Terraform example RDS subnet group"
  subnet_ids = var.db_subnet_ids
}

resource "aws_db_instance" "app_db" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.eks.id
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  engine_version       = "11.5"

  skip_final_snapshot  = true
  storage_encrypted    = false
  identifier           = "floweryroad-app"
  username             = "floweryroad"
  password             = "ekstestekstest"
  vpc_security_group_ids = [var.eks_sg_id]
}

resource "aws_db_instance" "auth_db" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.eks.id
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  engine_version       = "11.5"

  skip_final_snapshot  = true
  storage_encrypted    = false
  identifier           = "floweryroad-auth"
  username             = "floweryroad"
  password             = "ekstestekstest"
  vpc_security_group_ids = [var.eks_sg_id]
}
