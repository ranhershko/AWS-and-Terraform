#! /bin/bash 
packer build template.packer && terraform validate && terraform apply -auto-approve 

