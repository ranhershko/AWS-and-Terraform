variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "opschl_tags" {
  type = map
  default = {prefix_name = "opschl_ha_db_ha"}
}