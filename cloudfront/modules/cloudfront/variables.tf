variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  type        = string
}

variable "default_tags" {
  description = "List of default tags for module"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  type        = string
  description = "The domain name for your website (e.g., example.com)"
}

variable "environment" {
  type        = string
  description = "The environment (dev, stage, prod)"
}