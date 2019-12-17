output "public_instances_ip_mask" {
  value       = (var.public_instance == true ? formatlist("%s/32", aws_instance.opschl.*.public_ip) : [""])
}
