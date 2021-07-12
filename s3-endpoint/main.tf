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

module "vpc_endpoint" {
  source = "./vpc_endpoint"
  vpc_id = module.vpc.id
  route_table_id = module.vpc.private_route_table_id
}

module "s3" {
  source = "./s3"
  aws_vpc_endpoint_id = module.vpc_endpoint.id
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.id
}

module "iam" {
  source = "./iam"
  s3_arn = module.s3.arn
}

resource "aws_instance" "bastion" {
  ami = "ami-0094965d55b3bb1ff"
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnet_id
  key_name = module.key.name
  vpc_security_group_ids = [
    module.sg.bastion_ec2_id
  ]
  associate_public_ip_address = true
}

resource "aws_instance" "s3_access_ec2" {
  ami = "ami-0094965d55b3bb1ff"
  instance_type = "t2.micro"
  subnet_id = module.vpc.private_subnet_id
  key_name = module.key.name
  iam_instance_profile = module.iam.instance_profile_name
  vpc_security_group_ids = [
    module.sg.s3_access_ec2_id
  ]
}
