# Cognito Setup Guide

This guide will help you setup a Cognito User Pool in AWS.

## Steps

1. Initialize the Terraform configuration
   1. Navigate to the appropriate environment directory and run terraform init based on below

``` bash
# for stage environment
terraform init -backend-config="profile=galesstage" -backend-config="bucket=gales-stage-tf-state"

# for prod environment
terraform init -backend-config="profile=galesprod" -backend-config="bucket=gales-prod-tf-state" -backend-config="key=vpc/terraform.tfstate"
```
