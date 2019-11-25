resource "aws_subnet" "opschl_subnet"{
  count = var.obj_type_count
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, var.sub_cidr_init + count.index)
  map_public_ip_on_launch = var.public
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available))
  tags = merge(local.common_tags, {Name = "${var.opschl_tags["prefix_name"]}-${var.public == true ? "pub" : "priv" }-${var.svc_sub_type}SUB${count.index + 1}"})
}

resource "aws_eip" "opschl_nat_ip" {
  vpc   = true
  count = (var.public == false ? var.obj_type_count : 0)
}

resource "aws_nat_gateway" "opschl_nat_gw" {
  count         = (var.public == false ? var.obj_type_count : 0)
  allocation_id = element(aws_eip.opschl_nat_ip.*.id, count.index)
  subnet_id     = aws_subnet.opschl_subnet[count.index].id
  tags = merge(local.common_tags, {Name = "${var.opschl_tags["prefix_name"]}-${var.svc_sub_type}NAT${count.index + 1}"})
}

resource "aws_internet_gateway" "opschl_internet_igw" {
  count         = (var.public == true ? 1 : 0)
  vpc_id = var.vpc_id
  tags   = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${var.svc_sub_type}-igw" })
}

resource "aws_route_table" "opschl_public_rt" {
  count         = (var.public == true ? 1 : 0)
  vpc_id = var.vpc_id
  route {
    cidr_block = var.default_cidr
    gateway_id = aws_internet_gateway.opschl_internet_igw[0].id
  }
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-public-${var.svc_sub_type}RT" })
}

resource "aws_route_table" "opschl_private_rt" {
  count  = (var.public == false && var.obj_type_count > 0 ? var.obj_type_count : 0)
  vpc_id = var.vpc_id
  route {
    cidr_block = var.default_cidr
    gateway_id = aws_nat_gateway.opschl_nat_gw[count.index].id
  }
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-private-${var.svc_sub_type}RT${count.index + 1}" })
}

resource "aws_route_table_association" "opschl_public_rt_associate" {
  count = (var.public == true ? var.obj_type_count : 0)
  subnet_id = element(aws_subnet.opschl_subnet.*.id, count.index)
  route_table_id = aws_route_table.opschl_public_rt[0].id
}

resource "aws_route_table_association" "opschl_private_rt_associate" {
  count = (var.public == false && var.obj_type_count > 0 ? var.obj_type_count : 0)
  subnet_id      = element(aws_subnet.opschl_subnet.*.id, count.index)
  route_table_id = aws_route_table.opschl_private_rt[count.index].id
}
