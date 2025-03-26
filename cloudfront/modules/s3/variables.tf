variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "deploy_default_index" {
  type = bool
  description = "Deploy a default index.html file to the bucket"
  default = true
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
  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "The environment must be one of 'dev', 'stage', or 'prod'."
  }
}