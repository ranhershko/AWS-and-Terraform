output "instance_web1_url" {
  value = "http://${aws_instance.opschl_ha_web_db[0].public_dns}"
}

output "instance_web2_url" {
  value = "http://${aws_instance.opschl_ha_web_db[1].public_dns}"
}
