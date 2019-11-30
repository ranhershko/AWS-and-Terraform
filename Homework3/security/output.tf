output "pub_sg_ids" {
  value = module.security_web.pub_sg_id
}

output "priv_sg_ids" {
  value = module.security_db.priv_sg_id
}

output "pub_lb_sg_id" {
  value = module.security_web.pub_lb_sg_id
}
