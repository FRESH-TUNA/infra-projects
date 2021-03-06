terraform {
  required_version = "1.0.1"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module aws_caller_identity {
  source = "./aws_caller_identity"
}

module "vpc" {
  source = "./vpc"
}

module "vpc_endpoint" {
  source = "./vpc_endpoint"
  vpc_id = module.vpc.id
  route_table_id = module.vpc.route_table_id
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.id
}

module "aurora" {
  source = "./aurora"
  sg_id = module.sg.database_id
  subnet_ids = module.vpc.private_subnet_ids
}
