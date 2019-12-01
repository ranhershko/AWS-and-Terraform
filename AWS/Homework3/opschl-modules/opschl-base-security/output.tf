output "pub_sg_id" {
  value = (var.svc_name == "web" && var.current_count > 0 ? aws_security_group.opschl_svc-sg-allow[0].id : "")
}

output "priv_sg_id" {
  value = (var.svc_name == "db" && var.current_count > 0 ? aws_security_group.opschl_svc-sg-allow[0].id : "")
}

output "pub_lb_sg_id" {
  value = (var.svc_name == "web" && var.current_count > 0 ? aws_security_group.opschl_public-lb-sg-allow[0].id : "")
}
