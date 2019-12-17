output "project" {
  value = var.opschl_tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.cidr
}

output "pub_subnet_ids" {
  value = module.public_subnet.public_subnet_ids
}

output "priv_subnet_ids" {
  value = module.privat_subnet.private_subnet_ids
}