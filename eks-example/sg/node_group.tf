resource "aws_security_group" "node_group" {
	name = "kuberkuber-eks"
	description = "node group"
	vpc_id = var.eks_vpc_id

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "kuberkuber-eks"
	}
}
