module "web_instance" {
  source              = "../opschl-modules/opschl-base-instance-n-loadbalancer"
  instances_count     = length(data.terraform_remote_state.vpc.outputs.pub_subnet_ids)
  opschl_tags         = data.terraform_remote_state.vpc.outputs.project
  instance_key_pair   = "opschl_web_key"
  public_instance     = true
  subnet_ids          = data.terraform_remote_state.vpc.outputs.pub_subnet_ids
  ami_id              = data.aws_ami.opschl_web_db_ha-web_ami.id
  pub_lb_sg_id        = data.terraform_remote_state.security.outputs.pub_lb_sg_id
  sg_ids              = data.terraform_remote_state.security.outputs.pub_sg_ids
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  public_instances_ip = module.web_instance.public_instances_ip_mask
}

module "db_instance" {
  source              = "../opschl-modules/opschl-base-instance-n-loadbalancer"
  instances_count     = length(data.terraform_remote_state.vpc.outputs.priv_subnet_ids)
  opschl_tags         = data.terraform_remote_state.vpc.outputs.project
  instance_key_pair   = "opschl_db_key"
  public_instance     = false
  subnet_ids          = data.terraform_remote_state.vpc.outputs.priv_subnet_ids
  ami_id              = data.aws_ami.opschl_web_db_ha-db_ami.id
  pub_lb_sg_id        = ""
  sg_ids              = data.terraform_remote_state.security.outputs.priv_sg_ids
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  public_instances_ip = [""]
}
