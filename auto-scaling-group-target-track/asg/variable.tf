variable "aws_launch_template_id" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "description"
}

