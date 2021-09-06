# vpc
resource "aws_vpc" "tuna-infra" {
  cidr_block = "172.16.0.0/24"
  enable_dns_hostnames = true

  # tags = {
  #   Name = "tuna-eks-cluster"
  #   "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  # }
  tags = {
    Name = "tuna-infra"
  }
}
