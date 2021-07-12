variable "key_name" {
  type = string
}

variable "app_envs_path" {
  type = string
}

variable "app_cloudfront_private_key_env_path" {
  type = string
}

variable "eip_allocation_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list
}

variable "instance_profile_name" {
  type = string
}

variable "aws_default_region" {
  type = string
}
