terraform {
  required_version = "0.13.5"

  required_providers {
    aws = ">= 2.53.0"
  }
}

provider "aws" {
  region = var.AWS_DEFAULT_REGION
}

module aws_caller_identity {
  source = "./aws_caller_identity"
}

module "vpc" {
  source = "./vpc"
}

module "eip" {
  source = "./eip"
}

module "key" {
  source = "./key"
}

module "rds" {
  source = "./rds"
  private_subnet_ids = module.vpc.private_subnet_ids
  sg_id = module.sg.database_id
  identifier = var.DB_NAME
  username = var.DB_USER
  password = var.DB_PASSWORD
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.id
}

module "cloudfront_oai" {
  source = "./cloudfront_oai"
}

module "s3" {
  source = "./s3"
  app_role_id = module.iam.app_role_id
  cloudfront_oai_app_iam_arn = module.cloudfront_oai.app_iam_arn
}

module "cloudfront" {
  source = "./cloudfront"
  cloudfront_public_key = var.CLOUDFRONT_PUBLIC_KEY
  bucket_regional_domain_name = module.s3.app_bucket_regional_domain_name
  app_cloudfront_access_identity_path = module.cloudfront_oai.app_cloudfront_access_identity_path
  account_id = module.aws_caller_identity.account_id
  app_aliases = var.CLOUDFRONT_URL
}

module "parameter_store" {
  source = "./parameter_store"

  DB_HOST = module.rds.app_DB_HOST
  DB_PORT = var.DB_PORT
  DB_USER = var.DB_USER
  DB_PASSWORD = var.DB_PASSWORD
  DB_NAME = var.DB_NAME
  SECRET_KEY = var.SECRET_KEY

  CLOUDFRONT_URL = var.CLOUDFRONT_URL
  CLOUDFRONT_KEY_PAIR_ID = module.cloudfront.app_key_pair_id
  CLOUDFRONT_PRIVATE_KEY = var.CLOUDFRONT_PRIVATE_KEY

  ALLOWED_HOST = var.ALLOWED_HOST
  AWS_DEFAULT_REGION = var.AWS_DEFAULT_REGION
  AWS_STORAGE_BUCKET_NAME = module.s3.app_id
}

module "iam" {
  source = "./iam"
  account_id = module.aws_caller_identity.account_id
  eip_allocation_id = module.eip.allocation_id
  app_envs_arn = module.parameter_store.app_envs_arn
}

module "launch_template" {
  source = "./launch_template"
  key_name = module.key.key_name
  eip_allocation_id = module.eip.allocation_id
  app_envs_path = module.parameter_store.app_envs_path
  app_cloudfront_private_key_env_path = module.parameter_store.app_cloudfront_private_key_env_path
  vpc_security_group_ids = [module.sg.app_id]
  instance_profile_name = module.iam.instance_profile_name
  aws_default_region = var.AWS_DEFAULT_REGION
}

module "asg" {
  source = "./asg"
  aws_launch_template_id = module.launch_template.id
  subnet_ids = module.vpc.public_subnet_ids
}
