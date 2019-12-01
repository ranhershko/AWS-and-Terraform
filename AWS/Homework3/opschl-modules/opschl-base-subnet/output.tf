output "pub_sub_count" {
  value = (var.public == true ? length(aws_subnet.opschl_subnet) : 0)
}

output "priv_sub_count" {
  value = (var.public == false ? length(aws_subnet.opschl_subnet) : 0)
}

 output "common_tags" {
   value = local.common_tags
 }

output "public_subnet_ids" {
  value = (var.public == true && length(aws_subnet.opschl_subnet) > 0 ? aws_subnet.opschl_subnet.*.id : [])
}

output "private_subnet_ids" {
  value = (var.public == false && length(aws_subnet.opschl_subnet) > 0 ? aws_subnet.opschl_subnet.*.id : [])
}