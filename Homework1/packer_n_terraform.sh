#! /bin/bash 
packer build template.packer
if [[ "$?" -eq 0 ]] ; then
  echo "AWS AMI build by packer done"
  terraform validate
  if [[ "$?" -eq 0 ]] ; then
    echo "Terraform validate done"
    terraform plan
    if [[ "$?" -eq 0 ]] ; then
      echo "Terraform plan done"
      terraform apply -auto-approve 
    fi
    echo "AWS environment build done"
  fi
fi

