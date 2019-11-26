data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "opschl-web-db-ha-terrform-remote-state"
    key    = "vpc-terrform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket = "opschl-web-db-ha-terrform-remote-state"
    key    = "security-terrform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "opschl_ha_web_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_ha_web_db-webInstance-AMI*"]
  }
}

data "aws_ami" "opschl_ha_db_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_ha_web_db-dbInstance-AMI*"]
  }
}
