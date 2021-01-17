terraform {
  # To use S3 as the remote backend, comment out the below line
  backend "remote" {}

  # To use S3 as the backend, uncomment the below line
  #backend "s3" {}

  required_providers {
    aws = {
      version = ">= 2.28.1"
    }
    kubernetes = {
      version = ">= 1.13.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = var.cluster_name
}

#Setup the vpc
module "vpc" {
  source                     = "./modules/vpc"
  cluster_name               = local.cluster_name
  aws_region                 = var.aws_region
  vpc_name                   = var.vpc_name
  private_subnets            = var.private_subnets
  public_subnets             = var.public_subnets
  vpc_cidr                   = var.vpc_cidr
  worker_group_mgmt_one_cidr = var.worker_group_mgmt_one_cidr
  worker_group_mgmt_two_cidr = var.worker_group_mgmt_two_cidr
  worker_group_mgmt_all_cidr = var.worker_group_mgmt_all_cidr
}

# Create the eks cluster
module "eks" {
  source                                   = "./modules/eks"
  aws_security_group_worker_group_mgmt_one = module.vpc.aws_security_group_worker_group_mgmt_one
  aws_security_group_worker_group_mgmt_two = module.vpc.aws_security_group_worker_group_mgmt_two
  vpc_id                                   = module.vpc.vpc_id
  private_subnets                          = module.vpc.private_subnets
  cluster_name                             = local.cluster_name
  cluster_version                          = var.cluster_version
}
