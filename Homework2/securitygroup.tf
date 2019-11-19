resource "aws_security_group" "opschl_nginx-sg-web-allow" {
  vpc_id      = aws_vpc.opschl_ha_web_db_net1.id
  name        = "${var.opschl_tags["prefix_name"]}-web-sg-allow"
  description = "allow ssh from my_ip and http world wide"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.opschl_ha_web_db-world-wide-cidr_block]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.opschl_ha_web_db-world-wide-cidr_block]
    protocol    = "tcp"
  }

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-web-sg-allow" })
}

resource "aws_security_group" "opschl_nginx-sg-db-allow" {
  vpc_id      = aws_vpc.opschl_ha_web_db_net1.id
  name        = "${var.opschl_tags["prefix_name"]}-db-sg-allow"
  description = "allow ssh and mysql from web servers"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.opschl_ha_web_db-world-wide-cidr_block]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = slice(aws_subnet.opschl_ha_web_db-subnet.*.cidr_block, 0, 2)
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = slice(aws_subnet.opschl_ha_web_db-subnet.*.cidr_block, 0, 2)
    protocol    = "tcp"
  }

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-db-sg-allow" })
}
