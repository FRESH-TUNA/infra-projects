terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = ">= 3.50.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "./vpc"
}

module "sg" {
  source = "./sg"
  eks_vpc_id = module.vpc.id
}

module "iam" {
  source = "./iam"
}
