variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ssh_port" {
  description = "ssh port"
  type = number
  default = 22
}

variable "service_port" {
  description = "service port"
  type = number
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type = string
}

variable "internet_cidr" {
  description = "cidr for internet"
  type = string
}

variable "svc_name" {
  description = "service name"
  type = string
}

variable "vpc_id" {
  description = "vpc_id"
  type = string
}

variable "if_public_lb" {
  description = "if public lb (true/false)"
  type = bool
}

variable "opschl_tags" {
  type = map
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    Created_By   = "Terraform-${var.opschl_tags["prefix_name"]}"
  }
}

