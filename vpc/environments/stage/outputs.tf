output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "default_security_group_id" {
  description = "The ID of the default security group"
  value       = module.vpc.default_security_group_id
}

output "web_security_group_id" {
  description = "The ID of the web security group"
  value       = module.vpc.web_security_group_id
}

output "ssh_security_group_id" {
  description = "The ID of the SSH security group"
  value       = module.vpc.ssh_security_group_id
}