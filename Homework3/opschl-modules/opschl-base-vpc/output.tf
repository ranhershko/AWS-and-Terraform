output "cidr" {
  value = aws_vpc.opschl-vpc.cidr_block
}

output "vpc_id" {
  value = aws_vpc.opschl-vpc.id
}

output "project" {
  value = var.opschl_tags["prefix_name"]
}