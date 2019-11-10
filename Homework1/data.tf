provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "opschl_nginx_ami" {
  most_recent = true
  name_regex  = "^OpsSchool-Rules-*"
  owners      = ["self"]

  filter {
    name   = "tag:ami-name"
    values = ["OpsSchool-Rules-*"]
  }
}

data "aws_caller_identity" "current" {}

