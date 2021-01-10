output "aws_security_group_worker_group_mgmt_one" {
  description = ""
  value       = aws_security_group.worker_group_mgmt_one.id
}

output "aws_security_group_worker_group_mgmt_two" {
  description = ""
  value       = aws_security_group.worker_group_mgmt_two.id
}

output "vpc_id" {
  description = ""
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = ""
  value       = module.vpc.private_subnets
}