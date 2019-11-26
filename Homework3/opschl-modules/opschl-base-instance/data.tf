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

public_instance == true ? data.aws_ami.opschl_ha_web_ami.id : data.aws_ami.opschl_ha_db_ami.id