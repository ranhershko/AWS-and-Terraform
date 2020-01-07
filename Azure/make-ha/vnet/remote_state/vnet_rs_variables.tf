variable "location" {
  type = string
}

variable "project" {
  default = {
    prefix_name = ""
  }
}

variable "stor_account_repl_type" {
  type = string
}

variable "stor_account_tier" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${var.project["prefix_name"]}-remotestate"
  }
}
