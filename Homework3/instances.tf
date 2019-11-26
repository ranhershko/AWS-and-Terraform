resource "aws_instance" "opschl_ha_web_db" {
  count                  = length(var.list_sub_type) * length(var.list_sub_name)
  instance_type          = var.instancetype
  key_name               = aws_key_pair.opschl_ha_web_db.key_name
  ami                    = count.index < 2 ? data.aws_ami.opschl_ha_web_ami.id : data.aws_ami.opschl_ha_db_ami.id
  subnet_id              = aws_subnet.opschl_ha_web_db-subnet[count.index].id
  vpc_security_group_ids = count.index < 2 ? ["${aws_security_group.opschl_ha_web_db-webnet-sg-allow.id}"] : ["${aws_security_group.opschl_ha_web_db-dbnet-sg-allow.id}"]
  tags = merge(local.common_tags, { Name = "${var.opschl_tags["prefix_name"]}-${count.index < 2 ? var.list_sub_type[0] : var.list_sub_type[1]}instance_${(count.index % (length(var.list_sub_type))) + 1}" })
}

