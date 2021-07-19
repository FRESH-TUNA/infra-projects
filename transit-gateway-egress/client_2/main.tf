terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = var.AWS_REGION
  access_key  = var.AWS_ACCESS_KEY_ID
  secret_key  = var.AWS_SECRET_ACCESS_KEY
}

module "vpc" {
  source = "./vpc"
  shared_tgw_arn = var.SHARED_TGW_ARN
}

module "tgw" {
  source = "./tgw"
  vpc_id = module.vpc.id
  subnets = [module.vpc.private_subnet_id]
  shared_tgw_arn = var.SHARED_TGW_ARN
}
