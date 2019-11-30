module "security_web" {
  source = "../opschl-modules/opschl-base-security"
  service_port = 80
  svc_name = "web"
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  opschl_tags = data.terraform_remote_state.vpc.outputs.project
  current_count = (length(data.terraform_remote_state.vpc.outputs.pub_subnet_ids) > 0 ? 1 : 0)
}

module "security_db" {
  source = "../opschl-modules/opschl-base-security"
  service_port = 3306
  svc_name = "db"
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  opschl_tags = data.terraform_remote_state.vpc.outputs.project
  current_count = (length(data.terraform_remote_state.vpc.outputs.priv_subnet_ids) > 0 ? 1 : 0)
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${data.terraform_remote_state.vpc.outputs.project.prefix_name}"
  }
}
