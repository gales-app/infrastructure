variable "azs" {
  description = "availability zone names"
  type        = list(string)
}

variable "cidr" {
  description = "cidr used for vpc network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "default_tags" {
  description = "List of default tags for module"
  type        = map(string)
  default     = {}
}

variable "office_ip" {
  type = string
  description = "Office IP address"
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "svc_name" {
  description = "Name of main service"
  type        = string
}

variable "svc_prefix" {
  description = "Prefix of main service"
  type        = string
}

variable "svc_suffix" {
  description = "Suffix of main service"
  type        = string
  default     = "1"
}