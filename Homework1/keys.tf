resource "tls_private_key" "opschl_nginx" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "opschl_nginx" {
  key_name   = "opschl_nginx_key"
  public_key = tls_private_key.opschl_nginx.public_key_openssh
}

resource "local_file" "opschl_nginx-key-pair" {
  sensitive_content = tls_private_key.opschl_nginx.private_key_pem
  filename          = "opschl_nginx.pem"
}


