variable "local_dns_servers" {
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "location" {
  default = "West Europe"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "project" {
  default = {
    prefix_name = "testMe"
  }
}

variable "subnet1_address_prefix" {
  default = "10.0.0.0/24"
}

variable "subnet2_address_prefix" {
  default = "10.0.1.0/24"
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    CreatedBy   = "Terraform-azure-${var.project["prefix_name"]}"
  }
}
