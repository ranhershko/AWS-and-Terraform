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
