# VPC Setup Guide

This guide will help you setup a VPC in AWS.

> !IMPORTANT
> After adding a peering connection in MongoDB Atlas, you need to modify the routes for each private subnet in the VPC to connect to the Atlas VPC. This is done by adding a route to the Atlas VPC CIDR block with the target being the peering connection ID. The peering connection ID can be found in the MongoDB Atlas UI under Network Peering.  
> For more details [see Mongo docs](https://www.mongodb.com/docs/atlas/security-vpc-peering/) and [AWS Docs on VPC Peering](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html).

## Nat Gateway

The NAT Gateway is used to allow instances in a private subnet to connect to the internet while preventing the internet from initiating connections with those instances. As such, I've elected for cost reasons to NOT use a NAT Gateway in the stage environment, and unless there's a need otherwise, the production will be similarily configured.  

## Steps

1. Initialize the Terraform configuration
   1. Navigate to the appropriate environment directory and run terraform init based on below

``` bash
# for stage environment
terraform init -backend-config="profile=galesstage" -backend-config="bucket=gales-stage-tf-state"

# for prod environment
terraform init -backend-config="profile=galesprod" -backend-config="bucket=gales-prod-tf-state" -backend-config="key=vpc/terraform.tfstate"
```
