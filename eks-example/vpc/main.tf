# vpc
resource "aws_vpc" "eks" {
  cidr_block = "172.16.0.0/24"
  enable_dns_hostnames = true
  tags = {
    Name = "knufesta2019_vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
