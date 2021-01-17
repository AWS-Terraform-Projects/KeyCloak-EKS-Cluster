  module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.private_subnets

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [var.aws_security_group_worker_group_mgmt_one]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [var.aws_security_group_worker_group_mgmt_two]
      asg_desired_capacity          = 1
    },
  ]
}

provider "kubernetes" {
  load_config_file       = "false"
  host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, list("")), 0)
  token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, list("")), 0)
  cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, list("")), 0))
}

data "aws_eks_cluster" "cluster" {
  name  = module.eks_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name  = module.eks_cluster.cluster_id
}