#! /bin/bash 
packer build template.packer && terraform validate && terraform plan -out opschl_nginx.tfplan && terraform apply -auto-approve "opschl_nginx.tfplan"

