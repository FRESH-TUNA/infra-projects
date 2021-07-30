variable "eks_cluster_role_arn" {
  type = string
}

variable "eks_cluster_subnets" {
  type = list
}

variable "eks_node_group_arn" {
  type = string
}
