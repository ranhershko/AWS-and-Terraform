# Terraform & Packer
This folder contains a Terraform & Packer configuration that deploys 4 ubuntu servers (2 nginx servers and 2 mysql servers) with internal load balancer for mysql servers and public load balancer for web servers.
The resources is highly available and secure in AWS environment. The packer builds with Packer template and runs 4 EC2 Instances that uses it 


## AWS key pair
  AWS key-pair will be create automatically and save on local dir

## Prerequisites
  ### Configure your AWS credentials using
  run:
  aws configure

  ### Install terraform & packer
  Install Terraform and make sure it's on your PATH.
  Install Packer and make sure it's on your PATH.

  ### For initialize terraform run
  terraform init
  

## Running this module automatically
./shell/packer_n_terraform.sh

## Running this module manually

### Building AWS AMI image
packer build Packer/web/template.packer && packer build Packer/db/template.packer

### Validate terraform code
terraform validate

### Display terraform configuration plan
terraform plan -out opschl_ha_web_db.tvplan

### Deploy AWS terraform configuration
terraform apply -auto-approve "opschl_ha_web_db.tvplan"

### The output in the end will show you the instances URL of the web servers.

## When you're done, run
terraform destroy -auto-approve
### The AWS AMI images that been created and the disks snapshot needs to delete manually
