variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "list_sub_type" {
  description = "VPC subnets type list"
  type        = list
  default     = ["web", "db"]
}

variable "list_sub_name" {
  description = "VPC subnets name list"
  type        = list
  default     = ["sub1", "sub2"]
}

locals {
  sub_list = "${setproduct(var.list_sub_type, var.list_sub_name)}"
}

variable "opschl-web-db-ha-vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "net_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_ids" {
  default = module.public_subnet.
}
