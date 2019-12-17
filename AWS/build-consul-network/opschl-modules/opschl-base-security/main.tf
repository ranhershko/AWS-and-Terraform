resource "aws_security_group" "opschl_svc-sg-allow" {
  count = (var.current_count > 0 ? 1 : 0)
  vpc_id      = var.vpc_id
  name        = "${var.opschl_tags["prefix_name"]}-${var.svc_name}net-sg-allow"
  description = "allow ssh from my_ip and ${var.svc_name} from vpc_cidr only"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_cidr]
  }
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = (var.svc_name == "web" ? ["${chomp(data.http.myip.body)}/32"] : [var.vpc_cidr])
  }
  ingress {
    from_port   = var.service_port
    to_port     = var.service_port
    cidr_blocks = [var.vpc_cidr]
    protocol    = "tcp"
  }

  tags = merge(local.common_tags,  { Name = "${var.opschl_tags["prefix_name"]}-${var.svc_name}net-sg-allow" })
}

resource "aws_security_group" "opschl_public-lb-sg-allow" {
  count = (var.svc_name == "web" && var.current_count > 0 ? 1 : 0)
  vpc_id      = var.vpc_id
  name        = "${var.opschl_tags["prefix_name"]}-public-lb-sg-allow"
  description = "allow lb http from world wide"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.internet_cidr]
  }
  ingress {
    from_port   = var.service_port
    to_port     = var.service_port
    cidr_blocks = [var.internet_cidr]
    protocol    = "tcp"
  }

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-public-lb-sg-allow" })
}

