#! /bin/bash -xv
pub_sub_id=`grep -A1 pub_subnet_ids /tmp/vpc.info|tail -1|awk -F\" '{print $2}'`
sed 's/\(\"subnet_id\":\)\(.*\)/\1 \"'$pub_sub_id'\"\,/' ./Packer/web/template.packer  > ./Packer/web/template.packer.new ; \mv ./Packer/web/template.packer.new ./Packer/web/template.packer
sed 's/\(\"subnet_id\":\)\(.*\)/\1 \"'$pub_sub_id'\"\,/' ./Packer/db/template.packer  > ./Packer/db/template.packer.new ; \mv ./Packer/db/template.packer.new ./Packer/db/template.packer
