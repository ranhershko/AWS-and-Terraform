variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "opschl_nginx-vpc1-cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instancetype" {
  description = "Nginx OpsSchool instance type"
  type        = string
  default     = "t2.medium"
}

variable "opschl_tags" {
  type = map
  default = {
    prefix_name = "opschl_nginx"
    owner       = "Ran"
    purpose     = "learning"
  }
}

variable "server_name" {
  description = "instance server public hostname"
  type        = string
  default     = "localhost"
}

variable "resource_count" {
  description = "Resource count needed"
  type        = number
  default     = 2
}

locals {
  common_tags = {
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
  }
}