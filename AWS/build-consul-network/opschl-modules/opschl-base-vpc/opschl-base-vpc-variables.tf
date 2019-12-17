
variable "opschl_tags" {
  type = map
  default = {prefix_name = "opschl"}
}

variable "create_igw" {
  description = "Internet GW attach (true/false)"
  default     = "true"
}

variable "instance_tenancy" {
  description = "Instance tenancy"
  default     = "default"
}

variable "net_cidr" {
  description = "CIDR block for the VPC"
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  default     = "true"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  default     = "true"
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    CreatedBy   = "Terraform-${var.opschl_tags["prefix_name"]}"
  }
}
