resource "aws_security_group" "eks_db" {
	name = "eks_db"
	description = "eks_db"
	vpc_id = var.eks_vpc_id

	tags = {
		Name = "kuberkuber-eks"
	}
}

resource "aws_security_group_rule" "db_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_db.id
  source_security_group_id = var.eks_sg_id
  type                     = "ingress"
}
