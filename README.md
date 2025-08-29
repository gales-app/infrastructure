# Terraform Infrastructure as Code

This repository contains the Terraform code to create the following resources in AWS:

- VPC
- CloudFront

## Steps

1. Create a bucket for the terraform state file

## State File Bucket Creation

``` bash
# stage us-east-1 environment
aws s3api create-bucket --bucket gales-stage-tf-state --region us-east-1 --profile galesstage

# stage ca-central-1 environment
# Note: The `LocationConstraint` is required for buckets in regions other than us-east-1, which, strictly speaking, is not required for our purposes, but is included for consistency.
aws s3api create-bucket --bucket gales-stageca-tf-state --region ca-central-1 --create-bucket-configuration LocationConstraint=ca-central-1 --profile galesstageca

# prod environment
aws s3api create-bucket --bucket gales-prod-tf-state --region us-east-1 --profile galesprod
```
