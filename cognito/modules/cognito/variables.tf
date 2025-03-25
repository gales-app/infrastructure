variable "default_tags" {
  description = "List of default tags for module"
  type        = map(string)
  default     = {}
}

variable "reply_to_email_address" {
  description = "The email address that is sending the email"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "user_pool_name" {
  description = "The name of the user pool"
  type        = string
}