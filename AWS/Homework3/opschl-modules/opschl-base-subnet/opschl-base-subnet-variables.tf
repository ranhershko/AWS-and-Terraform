variable "obj_type_count" {
  description = "Object type count"
  type = number
}

variable "svc_sub_type" {
  description = "VPC subnets service type"
  type        = string
}

variable "vpc_id" {
  description = "AWS vpc ID"
  type = string
}

variable "vpc_cidr" {
  description = "default route cidr block"
  type = string
}

variable "default_cidr" {
  description = "default route cidr block"
  type = string
  default = "0.0.0.0/0"
}

variable "sub_cidr_init" {
  description = "sub_cidr init"
  type = number
}
variable "public" {
  description = "map public network"
  type = bool
}

variable "opschl_tags" {
  type = map
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    Created_By   = "Terraform-${var.opschl_tags["prefix_name"]}"
  }
}