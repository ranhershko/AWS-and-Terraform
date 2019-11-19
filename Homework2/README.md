# Terraform & Packer
This folder contains a Terraform & Packer configuration that deploys 4 ubuntu servers resources highly available and secure AWS environment. The packer builds with Packer template and runs 4 EC2 Instances that uses it 


## Prerequisites
  ## Configure your AWS credentials using
  run:
  1) aws configure
  2) for key_value in "aws_access_key_id" "aws_secret_access_key" ; do export `grep $key_value ~/.aws/credentials| tr '[:lower:]' '[:upper:]'|awk '{print $1 $2 $3}'`;done

  ## Install terraform & packer
  Install Terraform and make sure it's on your PATH.
  Install Packer and make sure it's on your PATH.

  ## For initialize terraform run
  terraform init
  
  ## Create aws key pair
  AWS key-pair will be create automatically

# Running this module automatically
./packer_n_terraform.sh

# Running this module manually

## Building AWS AMI image
packer build template.packer

## Validate terraform code
terraform validate

## Display terraform configuration plan
terraform plan opschl_nginx.tfplan

## Deploy AWS terraform configuration
terraform apply -auto-approve "opschl_nginx.tfplan"

### The output in the end will show you the instances URL of the web servers.

## When you're done, run
terraform destroy -auto-approve
