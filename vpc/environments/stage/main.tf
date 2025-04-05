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
    key     = "vpc.tfstate"
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
  azs         = ["${local.region}a", "${local.region}b", "${local.region}c"]
  cidr        = "10.0.0.0/16"
  environment = "stage"
  office_ip   = "72.38.68.30"
  region      = "us-east-1"
  svc_name    = "vpc"
  svc_prefix  = local.environment
  svc_suffix  = "1"
  default_tags = {
    Environment = local.environment
    Terraform   = "true"
  }
}

# Create a VPC
module "vpc" {
  source = "../../modules/vpc"

  svc_name      = local.svc_name
  svc_prefix    = local.svc_prefix
  svc_suffix    = local.svc_suffix
  default_tags  = local.default_tags

  enable_nat_gateway = false
  single_nat_gateway = false

  cidr             = local.cidr
  azs              = local.azs
  office_ip        = local.office_ip
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}