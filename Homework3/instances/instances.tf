module "web_instance" {
  source = "../opschl-modules/opschl-base-instance"

  instances_count = length(data.terraform_remote_state.vpc.outputs.pub_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = true
  subnet_ids = data.terraform_remote_state.vpc.outputs.pub_subnet_ids
  ami_id = data.aws_ami.opschl_ha_web_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.pub_subnet_ids
}

module "db_instance" {
  source = "../opschl-modules/opschl-base-instance"

  instances_count = length(data.terraform_remote_state.vpc.outputs.priv_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = true
  subnet_ids = data.terraform_remote_state.vpc.outputs.priv_subnet_ids
  ami_id = data.aws_ami.opschl_ha_db_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.priv_subnet_ids
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${count.index < 2 ? var.list_sub_type[0] : var.list_sub_type[1]}instance_${(count.index % (length(var.list_sub_type))) + 1}" })
}

