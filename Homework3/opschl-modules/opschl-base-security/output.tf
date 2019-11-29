output "security_pub_ids" {
  value = (var.svc_name == "web" && var.current_count > 0 ? aws_security_group.opschl_svc-sg-allow[0].id : "")
}

output "security_priv_ids" {
  value = (var.svc_name == "db" && var.current_count > 0 ? aws_security_group.opschl_svc-sg-allow[0].id : "")
}

output "security_pub_lb_ids" {
  value = (var.svc_name == "web" && var.current_count > 0 ? aws_security_group.opschl_public-lb-sg-allow[0].id : "")
}
