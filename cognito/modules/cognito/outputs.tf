output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.pool.id
}

output "user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.pool.arn
}

output "user_pool_name" {
  description = "Name of the Cognito User Pool"
  value       = aws_cognito_user_pool.pool.name
}

# output "sales_client_id" {
#   description = "ID of the Sales app client"
#   value       = aws_cognito_user_pool_client.sales_client.id
# }

# output "sales_client_secret" {
#   description = "Secret of the Sales app client"
#   value       = aws_cognito_user_pool_client.sales_client.client_secret
#   sensitive   = true
# }

# output "dips_client_id" {
#   description = "ID of the Dips app client"
#   value       = aws_cognito_user_pool_client.dips_client.id
# }

# output "dips_client_secret" {
#   description = "Secret of the Dips app client"
#   value       = aws_cognito_user_pool_client.dips_client.client_secret
#   sensitive   = true
# }