output "security_pub_ids" {
  value = (var.svc_name == "web" ? aws_security_group.opschl_svc-sg-allow.id : "")
}

output "security_priv_ids" {
  value = (var.svc_name == "db" ? aws_security_group.opschl_svc-sg-allow.id : "")
}

output "security_pub_lb_id" {
  value = (aws_security_group.opschl_public-lb-sg-allow)
}
