variable "aws_region" {
  description = "AWS region this api gateway needs to be deployed"
}

variable "cluster_name" {
  description = "Set the cluster name"
  default     = "demo"
}

variable "cluster_version" {
  description = ""
  default     = "1.18"
}

variable "vpc_name" {
  description = "EKS cluster's VPC name"
  default     = "eks_vpc"
}

variable "vpc_cidr" {
  description = ""
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = ""
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "private_subnets" {
  description = ""
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "worker_group_mgmt_one_cidr" {
  description = ""
  default = [
    "10.0.0.0/8",
  ]
}

variable "worker_group_mgmt_two_cidr" {
  description = ""
  default = [
    "192.168.0.0/16",
  ]
}

variable "worker_group_mgmt_all_cidr" {
  description = ""
  default = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}
