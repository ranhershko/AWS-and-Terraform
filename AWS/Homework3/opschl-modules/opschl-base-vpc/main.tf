resource "aws_vpc" "opschl-vpc" {
  cidr_block = var.net_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  tags = merge(local.common_tags, {Name = "${var.opschl_tags["prefix_name"]}-vpc1"})
}




