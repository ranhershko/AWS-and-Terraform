resource "aws_instance" "opschl_nginx" {
  count                  = var.resource_count
  instance_type          = var.instancetype
  key_name               = aws_key_pair.opschl_nginx.key_name
  ami                    = data.aws_ami.opschl_nginx_ami.id
  subnet_id              = "${aws_subnet.opschl_nginx-subnet[count.index].id}"
  vpc_security_group_ids = ["${aws_security_group.opschl_nginx-sg-allow.id}"]
  user_data              = "${file("./mount_vol2.sh")}"
  ebs_block_device {
    device_name           = "/dev/xvdh"
    volume_type           = "gp2"
    volume_size           = 10
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    Name    = "${var.opschl_tags["prefix_name"]}-instance_${count.index + 1}"
    Owner   = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
    //    server_name = "${aws_instance.opschl_nginx[count.index].public_hostname}"
  }
}

