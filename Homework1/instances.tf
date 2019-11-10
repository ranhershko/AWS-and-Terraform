resource "aws_instance" "opschl_nginx" {
  count = 2
  instance_type = "${var.instancetype}"
  key_name = "opschl_nginx"
  ami = "${data.aws_ami.opschl_nginx_ami.id}"
  subnet_id = "${aws_subnet.opschl_nginx_subnet[count.index].id}"
  vpc_security_group_ids = ["${aws_security_group.opschl_nginx-sg-allow-ssh.id}", "${aws_security_group.opschl_nginx-sg-allow-http.id}"]
  user_data = "${file("./mount_vol2.sh")}"
  ebs_block_device {
    device_name           = "/dev/xvdh"
    volume_type           = "gp2"
    volume_size           = 10
    encrypted = true
    delete_on_termination = true
  }
  tags = {
    Name = "${var.opschl_tags["prefix_name"]}_instance_${count.index}"
    Owner = "${var.opschl_tags["owner"]}"
    Purpose = "${var.opschl_tags["purpose"]}"
    Server_Name = "${aws_instance.opschl_nginx[1].public_dns}"
  }
}
