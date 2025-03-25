# Terraform Infrastructure as Code

This repository contains the Terraform code to create the following resources in AWS:

- VPC
- CloudFront

## Steps

1. Create a bucket for the terraform state file

## State File Bucket Creation

``` bash
# stage environment
aws s3api create-bucket --bucket gales-stage-tf-state --region us-east-1 --profile galesstage

# prod environment
aws s3api create-bucket --bucket gales-prod-tf-state --region us-east-1 --profile galesprod
```
