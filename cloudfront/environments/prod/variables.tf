variable "aws_profile" {
  type        = string
  description = "The AWS profile to use for authentication"
}

variable "domain_name" {
  type        = string
  description = "The domain name for your website (e.g., example.com)"
}

variable "environment" {
  type        = string
  description = "The environment (dev, stage, prod)"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "The environment must be one of 'dev', 'stage', or 'prod'."
  }
}