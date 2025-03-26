variable "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "domain_name" {
  type        = string
  description = "The domain name for your website (e.g., example.com)"
}

variable "zone_id" {
  description = "The Route53 hosted zone ID"
  type        = string
}