resource "aws_vpc" "opschl_nginx-net1" {
  cidr_block           = var.opschl_nginx-vpc1-cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-net1"})
}

resource "aws_subnet" "opschl_nginx-subnet" {
  count                   = var.resource_count
  vpc_id                  = aws_vpc.opschl_nginx-net1.id
  cidr_block              = "${cidrsubnet(aws_vpc.opschl_nginx-net1.cidr_block, 8, count.index)}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-subnet${count.index + 1}"})
}

resource "aws_internet_gateway" "opschl_nginx-igw" {
  vpc_id = aws_vpc.opschl_nginx-net1.id
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-igw"})
}

resource "aws_route_table" "opschl_nginx-rt" {
  vpc_id = aws_vpc.opschl_nginx-net1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opschl_nginx-igw.id
  }
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-rt"})
}

resource "aws_route_table_association" "opschl_nginx-rt-associate" {
  count          = var.resource_count
  subnet_id      = "${aws_subnet.opschl_nginx-subnet[count.index].id}"
  route_table_id = aws_route_table.opschl_nginx-rt.id
}
