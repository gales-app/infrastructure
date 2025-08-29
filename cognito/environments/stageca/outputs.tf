output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  value       = module.cognito.user_pool_arn
}

output "user_pool_name" {
  description = "Name of the Cognito User Pool"
  value       = module.cognito.user_pool_name
}

# output "user_pool_domain" {
#   description = "Domain of the Cognito User Pool"
#   value       = module.cognito.user_pool_domain
# }

# output "user_pool_client_id" {
#   description = "ID of the Cognito User Pool Client"
#   value       = module.cognito.user_pool_client_id
# }

# output "user_pool_client_secret" {
#   description = "Secret of the Cognito User Pool Client"    
#   value       = module.cognito.user_pool_client_secre
# }
