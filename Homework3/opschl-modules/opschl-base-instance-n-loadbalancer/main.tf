resource "tls_private_key" "opschl" {
  count = (var.instances_count > 0 ? 1 : 0)
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "opschl" {
  count = (var.instances_count > 0 ? 1 : 0)
  key_name   = "${var.public_instance == true ? web : db}_key"
  public_key = tls_private_key.opschl.public_key_openssh
}

resource "local_file" "opschl" {
  count = (var.instances_count > 0 ? 1 : 0)
  sensitive_content = tls_private_key.opschl.private_key_pem
  filename          = "opschl_${var.public_instance == true ? web : db}.pem"
}

resource "aws_instance" "opschl_instance" {
  count                  = var.instances_count
  instance_type          = var.instance_type
  key_name               = aws_key_pair.opschl.key_name
  ami                    = data.ami_id
  subnet_id              = var.subnet_ids[count.index].id
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${var.public_instance == true ? web : db}-instance${count.index + 1}"})
}

resource "aws_lb" "opschl-webPublic" {
  count = (var.public_instance == true ? 1 : 0)
  name               = "${var.opschl_tags["prefix_name"]}-webPublic-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_instance == true ? "${aws_security_group.opschl_ha_web_db-public-lb-sg-allow.id}" : ""]
  subnets            = slice(aws_subnet.opschl_ha_web_db-subnet.*.id, 0, 2)

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-webPublic-lb" })
}

resource "aws_lb_listener" "opschl-webPublic" {
  load_balancer_arn = aws_lb.opschl_ha_web_db-webPublic.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl_ha_web_db-webPublic.arn
  }
}

resource "aws_lb_target_group" "opschl-webPublic" {
  name     = "${var.opschl_tags["prefix_name"]}-webPublic-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.opschl_ha_web_db_net1.id
}

resource "aws_lb_target_group_attachment" "opschl-webPublic" {
  count            = 2
  target_group_arn = aws_lb_target_group.opschl_ha_web_db-webPublic.arn
  target_id        = aws_instance.opschl_ha_web_db[count.index].id
  port             = aws_lb_target_group.opschl_ha_web_db-webPublic.port
}

resource "aws_lb" "opschl-dbPrivate" {
  name               = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = slice(aws_subnet.opschl_ha_web_db-subnet[*].id, 2, length(aws_subnet.opschl_ha_web_db-subnet))

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb" })
}

resource "aws_lb_listener" "opschl-dbPrivate" {
  load_balancer_arn = aws_lb.opschl_ha_web_db-dbPrivate.arn
  port              = "3306"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl_ha_web_db-dbPrivate.arn
  }
}

resource "aws_lb_target_group" "opschl-dbPrivate" {
  name     = "${var.opschl_tags["prefix_name"]}-dbPrivate-tg"
  port     = 3306
  protocol = "TCP"
  vpc_id   = aws_vpc.opschl_ha_web_db_net1.id
}

resource "aws_lb_target_group_attachment" "opschl-dbPrivate" {
  count            = 2
  target_group_arn = aws_lb_target_group.opschl_ha_web_db-dbPrivate.arn
  target_id        = aws_instance.opschl_ha_web_db[count.index + 2].id
  port             = aws_lb_target_group.opschl_ha_web_db-dbPrivate.port
}
