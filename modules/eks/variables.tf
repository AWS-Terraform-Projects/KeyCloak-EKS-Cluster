variable "create_cluster" {
  description = "Toggle yes/no to create the eks cluster"
}

variable "aws_security_group_worker_group_mgmt_one" {
  description = ""
}

variable "aws_security_group_worker_group_mgmt_two" {
  description = ""
}

variable "vpc_id" {
  description = ""
}

variable "private_subnets" {
  description = ""
}

variable "cluster_name" {
  description = ""
}