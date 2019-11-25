output "instance_web1_url" {
  value = "http://${aws_instance.opschl_ha_web_db[0].public_dns}"
}

output "instance_web2_url" {
  value = "http://${aws_instance.opschl_ha_web_db[1].public_dns}"
}

output "web_public_lb_url" {
  value = "http://${aws_lb.opschl_ha_web_db-webPublic.dns_name}"
}

output "db_instance1_private_ip" {
  value = "${aws_instance.opschl_ha_web_db[2].private_ip}"
}

output "db_instance2_private_ip" {
  value = "${aws_instance.opschl_ha_web_db[3].private_ip}"
}
