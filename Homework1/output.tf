output "instance_nginx1_url" {
  value = "http://${aws_instance.opschl_nginx[0].public_dns}"
}

output "instance_nginx2_url" {
  value = "http://${aws_instance.opschl_nginx[1].public_dns}"
}