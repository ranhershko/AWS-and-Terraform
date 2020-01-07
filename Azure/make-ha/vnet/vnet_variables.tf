variable "location" {
  type = string
}

variable "vnet_address_space" {
  type = list
}

variable "project" {
  type = map
}

variable "resources_count" {
  type = number
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}
