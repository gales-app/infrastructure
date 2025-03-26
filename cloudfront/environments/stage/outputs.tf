output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_regional_domain_name" {
  value = module.s3.bucket_regional_domain_name
}

output "apex_distribution_id" {
  value = module.cloudfront.apex_distribution_id
}

output "apex_distribution_domain_name" {
  value = module.cloudfront.apex_distribution_domain_name
}

output "domain_name" {
  value = local.domain_name
}

output "url" {
  value = "https://${local.domain_name}"
}