module "security_web" {
  source = "../opschl-modules/opschl-base-security"
  internet_cidr = "0.0.0.0/0"
  if_public_lb = false
  service_port = 80
  svc_name = "web"
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  opschl_tags = data.terraform_remote_state.vpc.outputs.project_prfix
}

module "security_db" {
  source = "../opschl-modules/opschl-base-security"
  internet_cidr = "0.0.0.0/0"
  if_public_lb = false
  service_port = 80
  svc_name = "db"
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  opschl_tags = data.terraform_remote_state.vpc.outputs.project_prfix
}

module "security_pub_lb" {
  source = "../opschl-modules/opschl-base-security"
  internet_cidr = "0.0.0.0/0"
  if_public_lb = false
  service_port = 80
  svc_name = "db"
  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  opschl_tags = data.terraform_remote_state.vpc.outputs.project_prfix
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${data.terraform_remote_state.vpc.outputs.project_prfix}"
  }
}
