variable "list_sub_type" {
  description = "VPC subnets type list"
  type        = "list"
  default     = ["web", "db"]
}

variable "list_sub_name" {
  description = "VPC subnets name list"
  type        = "list"
  default     = ["sub1", "sub2"]
}

locals {
  sub_list = "${setproduct(var.list_sub_type, var.list_sub_name)}"
}

variable "region" {
  description = "AWS Region"
  type        = "string"
  default     = "us-east-1"
}

variable "opschl_ha_web_db-vpc1-cidr_block" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "opschl_ha_web_db-world-wide-cidr_block" {
  type    = "string"
  default = "0.0.0.0/0"
}

variable "instancetype" {
  description = "HA web & db OpsSchool instance type"
  type        = "string"
  default     = "t2.micro"
}

variable "opschl_tags" {
  type = "map"
  default = {
    prefix_name = "opschl_ha_web_db"
    Owner = "Ran"
    Purpose = "Learning"
  }
}

variable "resource_count" {
  description = "Resource count needed"
  type        = number
  default     = 2
}

locals {
  common_tags = {
    Owner   = "${var.opschl_tags["Owner"]}"
    Purpose = "${var.opschl_tags["Purpose"]}"
  }
}
