#! /bin/bash 
packer build Packer/web/template.packer && packer build Packer/db/template.packer && terraform validate && terraform plan -out opschl_ha_web_db.tvplan && terraform apply -auto-approve "opschl_ha_web_db.tvplan"
