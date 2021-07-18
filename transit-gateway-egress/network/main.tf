terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = ">= 3.50.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
  access_key  = var.AWS_ACCESS_KEY_ID
  secret_key  = var.AWS_SECRET_ACCESS_KEY
}

module "vpc" {
  source = "./vpc"
  nat_gateway_id = module.nat.id
  client_1_cidr = var.CLIENT_1_CIDR
  transit_gateway_id = module.tgw.id
}

module "tgw" {
  source = "./tgw"
  vpc_id = module.vpc.id
  subnets = [module.vpc.private_subnet_id]
}

module "eip" {
  source = "./eip"
}

module "nat" {
  source = "./nat"
  allocation_id = module.eip.nat_allocation_id
  subnet_id = module.vpc.public_subnet_id
}

module "ram" {
  source = "./ram"
  tgw_arn = module.tgw.arn
  organization_arn = var.ORGANIZATIONS_ARN
}
