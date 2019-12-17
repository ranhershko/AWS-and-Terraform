module "vpc" {
  source = "../opschl-modules/opschl-base-vpc"

  net_cidr    = var.opschl-web-db-ha-vpc-cidr
  opschl_tags = var.opschl_tags
}

module "public_subnet" {
  source = "../opschl-modules/opschl-base-subnet"

  public         = true
  obj_type_count = 2
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.cidr
  svc_sub_type   = "web"
  sub_cidr_init  = 0
  opschl_tags = var.opschl_tags
  public_subnet_ids = [""]
}

module "privat_subnet" {
  source = "../opschl-modules/opschl-base-subnet"

  public         = false
  obj_type_count = 2
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.cidr
  svc_sub_type   = "db"
  sub_cidr_init  = module.public_subnet.pub_sub_count
  opschl_tags = var.opschl_tags
  public_subnet_ids = module.public_subnet.public_subnet_ids
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${module.vpc.project}"
  }
}

