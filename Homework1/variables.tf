variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "opschl_vpc1-cidr_block" {
  default = "10.0.0.0/16"
}

variable "instancetype" {
  description = "Nginx OpsSchool instance type"
  default     = "t2.medium"
}

variable "opschl_tags" {
  type = map
  default = {
    prefix_name = "opschl_nginx"
    owner       = "Ran"
    purpose     = "learning"
  }
}

variable "server_name" {
  description = "instance server public hostname"
  default     = "localhost"
}

variable "resource_count" {
  description = "Resource count needed"
  type        = number
  default     = 2
}