variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "opschl_vpc1_cidr_block" {
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
