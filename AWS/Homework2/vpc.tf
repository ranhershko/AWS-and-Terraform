resource "aws_vpc" "opschl_ha_web_db_net1" {
  cidr_block           = var.opschl_ha_web_db-vpc1-cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags                 = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-net1" })
}

resource "aws_subnet" "opschl_ha_web_db-subnet" {
  count                   = "${length(var.list_sub_type) * length(var.list_sub_name)}"
  vpc_id                  = aws_vpc.opschl_ha_web_db_net1.id
  cidr_block              = "${cidrsubnet(aws_vpc.opschl_ha_web_db_net1.cidr_block, 8, count.index)}"
  map_public_ip_on_launch = count.index < 2 ? true : false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index % length(var.list_sub_name)]}"
  tags                    = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${element(local.sub_list, count.index)[0]}${element(local.sub_list, count.index)[1]}" })
}

resource "aws_internet_gateway" "opschl_ha_web_db-igw" {
  vpc_id = aws_vpc.opschl_ha_web_db_net1.id
  tags   = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-igw" })
}

resource "aws_eip" "opschl_ha_web_db-nat-ip" {
  vpc   = true
  count = "${length(var.list_sub_name)}"
}

resource "aws_nat_gateway" "opschl_ha_web_db-natgw" {
  count         = "${length(var.list_sub_name)}"
  allocation_id = "${element(aws_eip.opschl_ha_web_db-nat-ip.*.id, count.index)}"
  subnet_id     = aws_subnet.opschl_ha_web_db-subnet[count.index].id
}

resource "aws_route_table" "opschl_ha_web_db-public-rt" {
  vpc_id = aws_vpc.opschl_ha_web_db_net1.id
  route {
    cidr_block = var.opschl_ha_web_db-world-wide-cidr_block
    gateway_id = aws_internet_gateway.opschl_ha_web_db-igw.id
  }
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-public-rt" })
}

resource "aws_route_table" "opschl_ha_web_db-private-rt" {
  count  = "${length(var.list_sub_name)}"
  vpc_id = aws_vpc.opschl_ha_web_db_net1.id
  route {
    cidr_block = var.opschl_ha_web_db-world-wide-cidr_block
    gateway_id = aws_nat_gateway.opschl_ha_web_db-natgw[count.index].id
  }
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-private-rt-${count.index + 1}" })
}

resource "aws_route_table_association" "opschl_ha_web_db-public-rt-associate" {
  count          = "${length(var.list_sub_name)}"
  subnet_id      = "${element(aws_subnet.opschl_ha_web_db-subnet.*.id, count.index)}"
  route_table_id = aws_route_table.opschl_ha_web_db-public-rt.id
}

resource "aws_route_table_association" "opschl_ha_web_db-private-rt-associate" {
  count          = "${length(var.list_sub_name)}"
  subnet_id      = "${element(aws_subnet.opschl_ha_web_db-subnet.*.id, count.index + 2)}"
  route_table_id = aws_route_table.opschl_ha_web_db-private-rt[count.index].id
}
