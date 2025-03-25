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
    key     = "cognito.tfstate"
    region  = "us-east-1"
    profile = var.aws_profile
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

locals {
  environment = "stage"
  region      = "us-east-1"
  svc_name    = "app-pool"
  # svc_prefix  = local.environment
  # svc_suffix  = "1"
  default_tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}

module "cognito" {
  source = "../../modules/cognito"

  user_pool_name = local.svc_name

  default_tags  = local.default_tags
  reply_to_email_address = var.reply_to_email_address
  # source = "git::
  # source = "git::XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  # environment = local.environment
  # region      = local.region
  # svc_name    = local.svc_name
}