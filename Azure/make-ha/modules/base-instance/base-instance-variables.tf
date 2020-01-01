variable "location" {
  type        = string
  description = "Resouce group location"
}

variable "instance_rg_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "sa_account_tier" {
  type = string
}

variable "sa_replic_type" {
  type = string
}

variable "project" {
  type        = map
  description = "Project name"
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

variable "count" {
  type = number
}

variable "vnet_address_space" {
  type        = list
  description = "Vnet address space"
}

variable "is_public" {
  type = bool
}

variable "subnet_id" {
  type = string
}

variable "packer_img_uri" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "public" {
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
