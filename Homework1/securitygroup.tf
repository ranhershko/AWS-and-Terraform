resource "aws_security_group" "opschl_nginx-sg-allow-ssh" {
  vpc_id      = "${aws_vpc.opschl_nginx_net1.id}"
  name        = "${var.opschl_tags["prefix_name"]}-sg-allow-ssh"
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
}

resource "aws_security_group" "opschl_nginx-sg-allow-http" {
  vpc_id      = "${aws_vpc.opschl_nginx_net1.id}"
  name        = "${var.opschl_tags["prefix_name"]}-sg-allow-http"
  description = "allow http"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
}

