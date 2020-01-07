variable "location" {
  type        = string
  description = "Resouce group location"
}

variable "stor_account_tier" {
  type = string
}

variable "stor_account_repl_type" {
  type = string
}

variable "project" {
  type        = map
  description = "Project info"
  default = {
    prefix_name = ""
  }
}

variable "vnet_address_space" {
  type        = list
  description = "Vnet address space"
}

variable "is_public" {
  type = bool
}

variable "availability_set_domain_count" {
  type = number
}

variable "packer_rg" {
  type = string
}

variable "managed_disk_type" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "vm_size" {
  type = string
}

variable "os_type" {
  type = string
}

variable "resources_count" {
  type = number
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${var.project["prefix_name"]}-vm"
  }
}
