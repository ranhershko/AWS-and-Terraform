provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  region                  = "${var.region}"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "opschl_ha_web_ami" {
  most_recent = true
  #name_regex  = "^opschl_ha_web_db-webInstance-AMI"
  owners = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_ha_web_db-webInstance-AMI*"]
  }
}

data "aws_ami" "opschl_ha_db_ami" {
  most_recent = true
  #name_regex  = "^opschl_ha_web_db-dbInstance-AMI*"
  owners = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_ha_web_db-dbInstance-AMI*"]
  }
}



data "http" "myip" {
  url = "http://ifconfig.co/ip"
}


