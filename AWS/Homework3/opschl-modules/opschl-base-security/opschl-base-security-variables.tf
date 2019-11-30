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
  default = "0.0.0.0/0"
}

variable "svc_name" {
  description = "service name"
  type = string
}

variable "vpc_id" {
  description = "vpc_id"
  type = string
}

variable "current_count" {
  type = number
}

variable "opschl_tags" {
  type = map
  default = {prefix_name = "opschl"}
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner = "Ran"
    Purpose = "Learning"
  }
}

