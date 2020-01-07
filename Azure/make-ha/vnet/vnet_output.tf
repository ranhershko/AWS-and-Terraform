output "pub_sub_count" {
  value = length(module.pub_subnet)
}

output "priv_sub_count" {
  value = length(module.priv_subnet)
}

output "public_subnet_ids" {
  value = (length(module.pub_subnet) > 0 ? module.pub_subnet.public_subnet_ids : [])
}

output "private_subnet_ids" {
  value = (length(module.priv_subnet) > 0 ? module.priv_subnet.private_subnet_ids : [])
}
