terraform {
  # To use S3 as the remote backend, comment out the below line
  #backend "remote" {}

  # To use S3 as the backend, uncomment the below line
  backend "s3" {}

  required_providers {
    aws = {
      version = ">= 2.28.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#Setup the vpc
locals {
  cluster_name = "training-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source = "./modules/vpc"
  cluster_name = local.cluster_name
  aws_region = var.aws_region
}

# Create the eks cluster
module "eks" {
  source = "./modules/eks"
  create_cluster  = var.create_cluster 
  aws_security_group_worker_group_mgmt_one = module.vpc.aws_security_group_worker_group_mgmt_one
  aws_security_group_worker_group_mgmt_two = module.vpc.aws_security_group_worker_group_mgmt_two
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_name = local.cluster_name
  count = var.create_cluster == "yes" ? 1 : 0
}
