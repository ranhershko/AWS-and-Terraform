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

variable "sg_ids" {
  description = "Security id"
  type = string
}

variable "pub_lb_sg_id" {
  description = "Pub lb Security id"
  type = string
}

variable "subnet_ids" {
  type = list
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

variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
