resource "tls_private_key" "opschl_ha_web_db" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "opschl_ha_web_db" {
  key_name   = "opschl_ha_web_db_key"
  public_key = tls_private_key.opschl_ha_web_db.public_key_openssh
}

resource "local_file" "opschl_ha_web_db-key-pair" {
  sensitive_content = tls_private_key.opschl_ha_web_db.private_key_pem
  filename          = "opschl_ha_web_db.pem"
}



