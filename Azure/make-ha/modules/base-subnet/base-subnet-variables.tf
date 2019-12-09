variable "location" {
  type        = string
  description = "Resouce group location"
}

variable "project" {
  type        = map
  description = "Project name"
  //    default = {}
  //        prefix_name = ""
  //    }
}

variable "vnet_rg_name" {
  description = "vnet resource group name"
  type        = string
}

variable "vnet_name" {
  description = "vnet name"
  type        = string
}

variable "sub_count" {
  type = number
}

variable "vnet_address_space" {
  type        = list
  description = "Vnet address space"
}

variable "is_public" {
  type = bool
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${var.project["prefix_name"]}"
  }
}
