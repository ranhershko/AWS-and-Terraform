resource "aws_security_group" "opschl_nginx-sg-allow" {
  vpc_id      = aws_vpc.opschl_nginx-net1.id
  name        = "${var.opschl_tags["prefix_name"]}-sg-allow"
  description = "allow ssh and http"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-sg-allow" })
}

