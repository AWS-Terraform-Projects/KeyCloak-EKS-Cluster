variable "aws_region" {
  description = "AWS region this api gateway needs to be deployed"
}

variable "create_cluster" {
  description = "Toggle yes/no to create the eks cluster"
  default = "yes"
}

variable "cluster_name" {
  description = "Set the cluster name"
  default = "demo"
}