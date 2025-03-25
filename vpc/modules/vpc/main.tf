module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  
  name = format("%s-%s", var.svc_name, var.svc_suffix)
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name = format("%s-%s", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  public_subnet_tags = merge(
    {
      Name = format("%s-%s-public", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  private_subnet_tags = merge(
    {
      Name = format("%s-%s-private", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  public_route_table_tags = merge(
    {
      Name = format("%s-%s-public", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  private_route_table_tags = merge(
    {
      Name = format("%s-%s-private", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  nat_eip_tags = merge(
    {
      Name = format("%s-%s", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  vpc_tags =  merge(
    {
      Name = format("%s-%s", var.svc_name, var.svc_suffix)
    },
    var.default_tags,
  )

  # Default security group
  # I'm assuming this is an additional 'hardening' in the sense that the default group is entirely closed
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress = []
  default_security_group_tags =  merge(
    {
      Name = "default-sg"
    },
    var.default_tags,
  )
}