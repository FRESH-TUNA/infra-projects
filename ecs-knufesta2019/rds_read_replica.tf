# resource "aws_db_subnet_group" "knufesta2019" {
#   name       = "knufesta2019"
#   subnet_ids = aws_subnet.database.*.id
# }

# resource "aws_db_instance" "knufesta2019" {
#   allocated_storage    = 10
#   engine               = "postgresql"
#   instance_class       = "db.t3.micro"
#   name                 = var.DB_NAME
#   username             = var.DB_USER
#   password             = var.DB_PASSWORD
#   skip_final_snapshot  = true
#   db_subnet_group_name = aws_db_subnet_group.knufesta2019.name
# }

# resource "aws_db_instance" "knufesta2019_replica" {
#   allocated_storage    = 10
#   engine               = "postgresql"
#   instance_class       = "db.t3.micro"
#   name                 = var.DB_NAME
#   # username             = var.DB_USER
#   # password             = var.DB_PASSWORD
#   skip_final_snapshot  = true
#   replicate_source_db = aws_db_instance.knufesta2019.arn
#   db_subnet_group_name = aws_db_subnet_group.knufesta2019.name
# }

# resource "aws_security_group" "knufesta2019_database" {
#   vpc_id = aws_vpc.knufesta2019.id

#   ingress {
#     from_port        = var.DB_PORT
#     to_port          = var.DB_PORT
#     protocol         = "tcp"
#     security_groups = [aws_security_group.instance_balancer_security_group.id]
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
