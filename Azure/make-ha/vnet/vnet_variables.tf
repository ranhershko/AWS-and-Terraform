variable "local_dns_servers" {
  default = []
}

variable "location" {
  default = "eastus2"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "project" {
  default = {
    prefix_name = "testMe"
  }
}
