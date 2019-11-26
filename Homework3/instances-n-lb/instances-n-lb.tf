module "web_instance" {
  source = "../opschl-modules/opschl-base-instance-n-loadbalancer"

  instances_count = length(data.terraform_remote_state.vpc.outputs.pub_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = true
  subnet_ids = data.terraform_remote_state.vpc.outputs.pub_subnet_ids
  ami_id = data.aws_ami.opschl_ha_web_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.pub_subnet_ids
}

module "db_instance" {
  source = "../opschl-modules/opschl-base-instance"

  instances_count = length(data.terraform_remote_state.vpc.outputs.priv_subnet_ids)
  opschl_tags = { prefix_name = "opschl-web-db-ha" }
  instance_key_pair = ""
  public_instance = false
  subnet_ids = data.terraform_remote_state.vpc.outputs.priv_subnet_ids
  ami_id = data.aws_ami.opschl_ha_db_ami.id
  vpc_security_group_ids = data.terraform_remote_state.security.output.priv_subnet_ids
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${count.index < 2 ? var.list_sub_type[0] : var.list_sub_type[1]}instance_${(count.index % (length(var.list_sub_type))) + 1}" })
}

resource "aws_lb" "opschl_ha_web_db-webPublic" {
  name               = "${var.opschl_tags["prefix_name"]}-webPublic-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.opschl_ha_web_db-public-lb-sg-allow.id}"]
  subnets            = slice(aws_subnet.opschl_ha_web_db-subnet.*.id, 0, 2)

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-webPublic-lb" })
}

resource "aws_lb_listener" "opschl_ha_web_db-webPublic" {
  load_balancer_arn = aws_lb.opschl_ha_web_db-webPublic.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl_ha_web_db-webPublic.arn
  }
}

resource "aws_lb_target_group" "opschl_ha_web_db-webPublic" {
  name     = "${var.opschl_tags["prefix_name"]}-webPublic-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.opschl_ha_web_db_net1.id
}

resource "aws_lb_target_group_attachment" "opschl_ha_web_db-webPublic" {
  count            = 2
  target_group_arn = aws_lb_target_group.opschl_ha_web_db-webPublic.arn
  target_id        = aws_instance.opschl_ha_web_db[count.index].id
  port             = aws_lb_target_group.opschl_ha_web_db-webPublic.port
}

resource "aws_lb" "opschl_ha_web_db-dbPrivate" {
  name               = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = slice(aws_subnet.opschl_ha_web_db-subnet[*].id, 2, length(aws_subnet.opschl_ha_web_db-subnet))

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb" })
}

resource "aws_lb_listener" "opschl_ha_web_db-dbPrivate" {
  load_balancer_arn = aws_lb.opschl_ha_web_db-dbPrivate.arn
  port              = "3306"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl_ha_web_db-dbPrivate.arn
  }
}

resource "aws_lb_target_group" "opschl_ha_web_db-dbPrivate" {
  name     = "${var.opschl_tags["prefix_name"]}-dbPrivate-tg"
  port     = 3306
  protocol = "TCP"
  vpc_id   = aws_vpc.opschl_ha_web_db_net1.id
}

resource "aws_lb_target_group_attachment" "opschl_ha_web_db-dbPrivate" {
  count            = 2
  target_group_arn = aws_lb_target_group.opschl_ha_web_db-dbPrivate.arn
  target_id        = aws_instance.opschl_ha_web_db[count.index + 2].id
  port             = aws_lb_target_group.opschl_ha_web_db-dbPrivate.port
}

locals {
  description = "Tags applied to all ressources"
  common_tags = {
    Owner     = "Ran"
    Purpose   = "Learning"
    CreatedBy = "Terraform-${module.vpc.project}"
  }
}
