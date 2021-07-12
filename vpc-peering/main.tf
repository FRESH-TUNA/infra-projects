terraform {
  required_version = "1.0.2"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = var.REQUESTER_AWS_REGION
  aws_access_key_id = var.REQUESTER_AWS_ACCESS_KEY_ID
  aws_secret_access_key = var.REQUESTER_AWS_SECRET_ACCESS_KEY
}

provider "aws" {
  alias  = "accepter"
  region = var.ACCEPTER_AWS_REGION
  aws_access_key_id = var.ACCEPTER_AWS_ACCESS_KEY_ID
  aws_secret_access_key = var.ACCEPTER_AWS_SECRET_ACCESS_KEY
}

module "vpc" {
  source = "./vpc"
}
