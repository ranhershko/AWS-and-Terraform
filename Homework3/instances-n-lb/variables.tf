variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  desfult = (var.public_instance == true ? data.aws_ami.opschl_web_db_ha-web_ami.id : data.aws_ami.opschl_web_db_ha-db_ami.id)
}