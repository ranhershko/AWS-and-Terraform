resource "aws_vpc" "opschl_nginx_net1" {
  cidr_block           = "${var.opschl_vpc1_cidr_block}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name    = "${var.opschl_tags["prefix_name"]}_net1"
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
  }
}

resource "aws_subnet" "opschl_nginx_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.opschl_nginx_net1.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.opschl_nginx_net1.cidr_block, 8, count.index)}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name    = "${var.opschl_tags["prefix_name"]}_subnet${count.index}"
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
  }
}

resource "aws_internet_gateway" "opschl_nginx_igw" {
  vpc_id = "${aws_vpc.opschl_nginx_net1.id}"
  tags = {
    Name    = "${var.opschl_tags["prefix_name"]}_igw"
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
  }
}

resource "aws_route_table" "opschl_nginx_rt" {
  vpc_id = "${aws_vpc.opschl_nginx_net1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.opschl_nginx_igw.id}"
  }
  tags = {
    Name    = "${var.opschl_tags["prefix_name"]}_rt"
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
  }
}

resource "aws_route_table_association" "opschl_nginx-associate" {
  count          = 2
  subnet_id      = "${aws_subnet.opschl_nginx_subnet[count.index].id}"
  route_table_id = "${aws_route_table.opschl_nginx_rt.id}"
}
