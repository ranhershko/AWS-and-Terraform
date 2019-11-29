output "pub_sg_ids" {
  value = module.security_web.security_pub_ids
}

output "priv_sg_ids" {
  value = module.security_db.security_priv_ids
}