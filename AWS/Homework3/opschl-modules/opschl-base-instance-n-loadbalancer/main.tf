resource "tls_private_key" "opschl" {
  count =  (var.instances_count > 0 ? 1 : 0)
  algorithm = "RSA"
  rsa_bits = 4096
  #name = "opschl_${var.public_instance == true ? "web" : "db"}_tls_private_key"
}

resource "aws_key_pair" "opschl" {
  count = (var.instances_count > 0 ? 1 : 0)
  key_name   = "opschl_${var.public_instance == true ? "web" : "db"}_key"
  public_key = tls_private_key.opschl[count.index].public_key_openssh
  #name = "opschl_${var.public_instance == true ? "web" : "db"}_pub_key_pair"

}

resource "local_file" "opschl" {
  count = (var.instances_count > 0 ? 1 : 0)
  sensitive_content = tls_private_key.opschl[count.index].private_key_pem
  filename          = "opschl_${var.public_instance == true ? "web" : "db"}.pem"
  #name = "opschl_${var.public_instance == true ? "web" : "db"}_pem_key_pair"
}

resource "aws_instance" "opschl" {
  count                  = var.instances_count
  instance_type          = var.instance_type
  key_name               = aws_key_pair.opschl[0].key_name
  ami                    = var.ami_id
  subnet_id              = var.subnet_ids[count.index]
  iam_instance_profile = (var.public_instance == true ? aws_iam_instance_profile.opschl_instance_profile[0].name : "")
  vpc_security_group_ids = [var.sg_ids]
  user_data = (var.public_instance == true ? "${file("${path.module}/shell/InstallFluentdSendApacheLogsS3.sh")}" : "")
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${var.public_instance == true ? "web" : "db"}Instance${count.index + 1}"})
  # depends_on             = [aws_s3_bucket.opschl-web-db-ha-nginx-accesslog]
}

resource "aws_lb" "opschl-webPublic" {
  count = (var.public_instance == true && var.instances_count > 0 ? 1 : 0)
  name               = "${var.opschl_tags["prefix_name"]}-webPublic-lb"
  internal           = false

  load_balancer_type = "application"
  security_groups    = [var.pub_lb_sg_id]
  subnets            = var.subnet_ids

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-webPublic-lb" })
}

resource "aws_lb_target_group" "opschl-webPublic" {
  count = (var.public_instance == true && var.instances_count > 0 ? 1 : 0)
  name     = "${var.opschl_tags["prefix_name"]}-webPublic-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1
    enabled         = true
  }
}

resource "aws_lb_listener" "opschl-webPublic" {
  count = (var.public_instance == true && var.instances_count > 0 ? 1 : 0)
  load_balancer_arn = aws_lb.opschl-webPublic[count.index].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl-webPublic[count.index].arn
  }
}

resource "aws_lb_target_group_attachment" "opschl-webPublic" {
  count = (var.public_instance == true && var.instances_count > 0 ? var.instances_count : 0)
  target_group_arn = aws_lb_target_group.opschl-webPublic[0].arn
  target_id        = aws_instance.opschl[count.index].id
  port             = aws_lb_target_group.opschl-webPublic[0].port
}

resource "aws_lb" "opschl-dbPrivate" {
  count = (var.public_instance == false && var.instances_count > 0 ? 1 : 0)
  name               = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-dbPrivate-lb" })
}

resource "aws_lb_target_group" "opschl-dbPrivate" {
  count = (var.public_instance == false && var.instances_count > 0 ? 1 : 0)
  name     = "${var.opschl_tags["prefix_name"]}-dbPrivate-tg"
  port     = 3306
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "opschl-dbPrivate" {
  count = (var.public_instance == false && var.instances_count > 0 ? 1 : 0)
  load_balancer_arn = aws_lb.opschl-dbPrivate[count.index].arn
  port              = "3306"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.opschl-dbPrivate[count.index].arn
  }
}

resource "aws_lb_target_group_attachment" "opschl-dbPrivate" {
  count            = (var.public_instance == false && var.instances_count > 0 ? var.instances_count : 0)
  target_group_arn = aws_lb_target_group.opschl-dbPrivate[0].arn
  target_id        = aws_instance.opschl[count.index].id
  port             = aws_lb_target_group.opschl-dbPrivate[0].port
}
