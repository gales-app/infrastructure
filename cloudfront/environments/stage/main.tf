terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Pin the AWS provider version
    }
  }
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket  = var.state_bucket
    region  = "us-east-1"
    profile = var.aws_profile
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1" # Replace with your desired AWS region
}

locals {
  acm_certificate_arn   = data.aws_acm_certificate.cert.arn
  bucket_name = "${var.domain_name}-${var.environment}"
  deploy_default_index = true // change to false once you have your own index.html (site uploaded) -- This will require a new deployment and invalidation to clear the cache
  domain_name = var.domain_name
  default_tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Data sources
data "aws_acm_certificate" "cert" {
  domain      = local.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}

// TODO: can we put into the route53 module and clean things up?
data "aws_route53_zone" "selected" {
  name         = local.domain_name
  private_zone = false  # Set to `true` if the zone is private
}

# S3 Module
module "s3" {
  source = "../../modules/s3"
  
  bucket_name           = local.bucket_name
  default_tags          = local.default_tags
  deploy_default_index  = local.deploy_default_index
  domain_name           = local.domain_name
  environment           = var.environment
}

# Route53 Module
module "route53" {
  source = "../../modules/route53"
  
  cloudfront_domain_name  = module.cloudfront.apex_distribution_domain_name
  domain_name             = local.domain_name
  zone_id                 = data.aws_route53_zone.selected.zone_id
}

# CloudFront Module
module "cloudfront" {
  source = "../../modules/cloudfront"
  
  acm_certificate_arn         = local.acm_certificate_arn
  bucket_name                 = local.bucket_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  default_tags                = local.default_tags
  domain_name                 = local.domain_name
  environment                 = var.environment
}

// Apply bucket policy after both s3 and cloudfront resources exist
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3.bucket_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "s3:GetObject",
        Effect = "Allow",
        Resource = "${module.s3.bucket_arn}/*",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.apex_distribution_arn
          }
        }
      }
    ]
  })
}