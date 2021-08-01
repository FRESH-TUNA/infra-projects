variable "cluster_role_arn" {
  type = string
}

variable "node_group_role_arn" {
  type = string
}

variable "cluster_subnets" {
  type = list
}

variable "cluster_security_group_ids" {
  type = list
}

variable "cluster_attachment_1" {}
variable "cluster_attachment_2" {}

variable "node_group_attachment_1" {}
variable "node_group_attachment_2" {}
variable "node_group_attachment_3" {}
