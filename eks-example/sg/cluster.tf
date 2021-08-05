# resource "aws_security_group" "cluster" {
# 	name = "kuberkuber-eks"
# 	description = "cluster"
# 	vpc_id = var.eks_vpc_id

# 	tags = {
# 		Name = "kuberkuber-eks"
# 	}
# }

# resource "aws_security_group_rule" "cluster_inbound" {
#   description              = "Allow worker nodes to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.cluster.id
#   source_security_group_id = aws_security_group.node_group.id
#   to_port                  = 443
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "cluster_outbound" {
#   description              = "Allow cluster API Server to communicate with the worker nodes"
#   from_port                = 1024
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.cluster.id
#   source_security_group_id = aws_security_group.node_group.id
#   to_port                  = 65535
#   type                     = "egress"
# }
