variable "cluster_name" {
  description = ""
}

variable "aws_region" {
  description = "AWS region this api gateway needs to be deployed"
}

variable "vpc_name" {
  description = "EKS cluster's VPC name"
}

variable "public_subnets" {
  description = ""
}

variable "private_subnets" {
  description = ""
}

variable "vpc_cidr" {
  description = ""
}

variable "worker_group_mgmt_one_cidr" {
  description = ""
}

variable "worker_group_mgmt_two_cidr" {
  description = ""
}

variable "worker_group_mgmt_all_cidr" {
  description = ""
}