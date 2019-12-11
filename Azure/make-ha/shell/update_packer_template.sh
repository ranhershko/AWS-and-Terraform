#!/bin/bash
# vpc dir
terraform apply --auto-approve ./vpc/ > /tmp/vpc.info
pub_sub_id=`grep -A1 pub_subnet_ids /tmp/vpc.info|tail -1|awk -F\" '{print $2}'`
sed 's/\(\"subnet_id\":\)\(.*\)/\1 \"'$pub_sub_id'\"\,/' ./Packer/web/template.packer  > ./Packer/web/template.packer.current 
sed 's/\(\"subnet_id\":\)\(.*\)/\1 \"'$pub_sub_id'\"\,/' ./Packer/db/template.packer  > ./Packer/db/template.packer.current 
\rm /tmp/vpc.info
