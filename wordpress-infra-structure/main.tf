terraform {
  required_version = "0.13.5"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}


module "vpc" {
  source = "./vpc"
}

module "key" {
  source = "./key"
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.id
}

module "iam" {
  source = "./iam"
  account_id = module.aws_caller_identity.account_id
  eip_allocation_id = module.eip.allocation_id
}

module "launch_template" {
  source = "./launch_template"
  key_name = module.key.key_name
  eip_allocation_id = module.eip.allocation_id
  vpc_security_group_ids = [module.sg.id]
  instance_profile_name = module.iam.instance_profile_name
}

module "asg" {
  source = "./asg"
  aws_launch_template_id = module.launch_template.id
  subnet_ids = module.vpc.public_subnet_ids
}
