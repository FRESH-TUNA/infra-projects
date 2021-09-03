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
  cluster_name = "floweryroad"
}

module "launch_template" {
  source = "./launch_template"
}

module "eks" {
  source = "./eks"
  cluster_name = "tuna-eks-cluster"
  
  cluster_role_arn = module.iam.cluster_arn
  node_group_role_arn = module.iam.node_group_arn

  cluster_subnets = concat(
    module.vpc.cluster_public_subnet_ids,
    module.vpc.cluster_private_subnet_ids
  )
  node_group_subnets = module.vpc.cluster_private_subnet_ids

  tuna-eks-cluster-node-launch_template_id = module.launch_template.tuna-eks-cluster-node_id
  # cluster_security_group_ids = [module.sg.cluster_id]
  
  # cluster_attachments
  cluster_attachment_1 = module.iam.cluster_attachment_amazonEKSClusterPolicy
  cluster_attachment_2 = module.iam.cluster_attachment_amazonEKSVPCResourceController

  # node_group_attachments
  node_group_attachment_1 = module.iam.node_group_attachment_amazonEKSWorkerNodePolicy
  node_group_attachment_2 = module.iam.node_group_attachment_amazonEKS_CNI_Policy
  node_group_attachment_3 = module.iam.node_group_attachment_amazonEC2ContainerRegistryReadOnly
}

module "iam" {
  source = "./iam"
  oidc_provider_thumbprint = module.eks.oidc_provider_thumbprint
  oidc_provider_issuer = module.eks.oidc_provider_issuer
}
