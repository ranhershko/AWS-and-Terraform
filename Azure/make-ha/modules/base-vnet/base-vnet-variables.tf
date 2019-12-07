variable "local_dns_servers" {
    type = list
    description = "Default local DNS servers list"
}

variable "location" {
    type = string
    description = "Resouce group location"
}

variable "vnet_address_space" {
    type = list
    description = "Vnet address space"
}

variable "project" {
    type = map
    description = "Project name"
    default = {
        prefix_name = ""
    }
}

variable "subnet1_address_prefix" {
    type = string
}

variable "subnet2_address_prefix" {
    type = string
}

variable "netwatcher" {
  description = "Network watcher creation. If set it will create Network Watcher resource using standard naming standard."
  type        = object({ resource_group_location = string, log_analytics_workspace_id = string })
  default     = null
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    CreatedBy   = "Terraform-${var.project["prefix_name"]}"
  }
}

