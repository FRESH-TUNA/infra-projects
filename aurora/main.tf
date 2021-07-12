terraform {
  required_version = "0.13.5"

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

module "sg" {
  source = "./sg"
}

module "aurora" {
  source = "./aurora"
  sg_id = module.sg.database_id
}
