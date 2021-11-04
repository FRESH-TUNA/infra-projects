terraform {
  required_version = "1.0.5"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "./vpc"
  nat_id = module.ec2.nat_id
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.id
}

module "launch_template" {
  source = "./launch_template"
  logic_security_group_ids = [module.sg.logic_id]
}

module "lb" {
  source = "./lb"
  lb_sg_ids = [module.sg.lb_id]
  lb_subnets = module.vpc.public_subnet_ids
  vpc_id = module.vpc.id
}

module "asg" {
  source = "./asg"
  aws_launch_template_id = module.launch_template.id
  subnet_ids = module.vpc.private_subnet_ids
  logic_target_group_arns = [module.lb.tuna_target_group_arn]
}

module "ec2" {
  source = "./ec2"
  nat_launch_template_id = module.launch_template.nat_id
  nat_sg_ids = [module.sg.nat_id]
  nat_subnet_id = module.vpc.public_subnet_ids[0]
}
