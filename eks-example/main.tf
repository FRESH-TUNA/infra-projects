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

module "aurora" {
  source = "./aurora"
  sg_id = module.sg.database_id
  subnet_ids = module.vpc.private_subnet_ids
}
