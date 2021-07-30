resource "aws_security_group" "eks_cluster" {
	name = "kuberkuber-eks"
	description = "Cluster communication with worker nodes"
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
