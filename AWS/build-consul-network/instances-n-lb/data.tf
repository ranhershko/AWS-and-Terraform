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

data "aws_ami" "opschl_web_db_ha-web_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_web_db_ha-webInstance-AMI*"]
  }
}

data "aws_ami" "opschl_web_db_ha-db_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["opschl_web_db_ha-dbInstance-AMI*"]
  }
}
