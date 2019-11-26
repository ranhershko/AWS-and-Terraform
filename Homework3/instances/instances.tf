module "web_instance" {
  source = "../opschl-modules/opschl-base-instance-n-loadbalancer"

  instances_count = length(data.terraform_remote_state.vpc.outputs.pub_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = true
  subnet_ids = data.terraform_remote_state.vpc.outputs.pub_subnet_ids
  ami_id = data.aws_ami.opschl_ha_web_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.pub_subnet_ids
}

module "db_instance" {
  source = "../opschl-modules/opschl-base-instance-n-loadbalancer"

  instances_count = length(data.terraform_remote_state.vpc.outputs.priv_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = true
  subnet_ids = data.terraform_remote_state.vpc.outputs.priv_subnet_ids
  ami_id = data.aws_ami.opschl_ha_db_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.priv_subnet_ids
  tags = merge(local.common_tags, { Name = "${opschl_tags["prefix_name"]}-${public_instance == true ? "pub" : "priv"}-instance${count.index + 1)) + 1}" })
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${module.vpc.project}"
  }
}

