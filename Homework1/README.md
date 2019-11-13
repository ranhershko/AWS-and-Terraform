# Terraform & Packer
This folder contains a Terraform & Packer configuration that deploys 2 ubuntu nginx servers resources in AWS. The packer builds with Packer template and runs 2 EC2 Instances that uses it 

## Prerequisites
  ## Configure your AWS credentials
  1) aws configure
  2) for key_value in "aws_access_key_id" "aws_secret_access_key" ; do export `grep $key_value ~/.aws/credentials| tr '[:lower:]' '[:upper:]'|awk '{print $1 $2 $3}'`;done

  ## Install terraform & packer
  Install Terraform and make sure it's on your PATH.
  Install Packer and make sure it's on your PATH.

  ## For initialize terraform run
  terraform init
  
  ## Create aws key pair
  aws ec2 create-key-pair --key-name opschl_nginx --query 'KeyMaterial' --output text > opschl_nginx.pem

# Running this module automaticaly
./packer_n_terraform.sh

# Running this module manually

## Building AWS AMI image
packer build template.packer

## Validate terraform code
terraform validate

## Display terraform configuration plan
terraform plan

## Deploy AWS terraform configuration
terraform apply -auto-approve 

### The output in the end will show you the instances URL of the web servers.

## When you're done, run
echo 'yes'|terraform destroy

