output "pub_sub_count" {
  value = (var.public == true ? length(aws_subnet.opschl_subnet) : 0)
}
