variable "instances_count" {
  description = "instances count"
  type        = number
}

variable "instance_type" {
  description = "HA web & db OpsSchool instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_key_pair" {
  description = "instance key_pair"
  type        = string
}

variable "public_instance" {
  description = "if instance is public(true/false)"
  type = bool
}

variable "subnet_ids" {
  type = list
}

variable "vpc_security_group_ids" {
  type = list
}

variable "opschl_tags" {
  type = map
}

variable "ami_id" {
  type = string
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner       = "Ran"
    Purpose     = "Learning"
    Created_By   = "Terraform-${var.opschl_tags["prefix_name"]}"
  }
}

