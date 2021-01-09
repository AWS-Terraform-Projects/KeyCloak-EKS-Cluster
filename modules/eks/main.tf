module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.17"
  subnets         = var.private_subnets
  count = var.create_cluster == "yes" ? 1 : 0

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

#provider "kubernetes" {
#  load_config_file       = "false"
#  host                   = try(data.aws_eks_cluster.cluster.endpoint,null)
#  token                  = try(data.aws_eks_cluster_auth.cluster.token,null)
#  cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data),null)
#}

data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.0.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.0.cluster_id
}