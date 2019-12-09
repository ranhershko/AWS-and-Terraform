variable "location" {
  default = "West Europe"
}

variable "project" {
  default = {
    prefix_name = "testMe"
  }
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${var.project["prefix_name"]}-vnet-remotestate"
  }
}