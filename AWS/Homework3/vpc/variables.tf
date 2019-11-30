variable "opschl_tags" {
  default = {
    prefix_name = "opschl-web-db-ha"
  }
}

variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "opschl-web-db-ha-vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "net_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


