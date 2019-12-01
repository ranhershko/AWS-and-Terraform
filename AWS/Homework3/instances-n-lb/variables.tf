variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

#variable "public_instances_ip" {
  #description = "List of public instances public IP's addresses"
  #type        = list
  #default       = (module.web_instance.public_instance == true ? aws_instance.opschl.*.public_ip : "")
#}
