# Terraform & Packer
This folder contains a Terraform & Packer configuration that deploys 4 ubuntu servers (2 nginx servers and 2 mysql servers) with internal load balancer for mysql servers and public load balancer for web servers.
The resources is highly available and secure in AWS environment. The packer builds with Packer template and runs 4 EC2 Instances that uses it 

## Update from Homework2
1) Update terraform code using AWS Terraform Modules, Remote State, Isolating state files
2) a) Install fluntd on web web servers for Nginx access log transfer to S3
   b) Create AWS role & policy for S3 write option and attach role to web servers
   c) Add S3 bucket for Nginx access log transfer
3) Add nginx.conf file to Packer web server installation for support client Ip log using Nginx X-forwarded-for log option

## AWS key pair
  AWS key-pair will be create automatically and save on local dir

## Prerequisites
  ### Configure your AWS credentials using
  aws configure

## Run manually
  ### Install terraform & packer
  Install Terraform and make sure it's on your PATH.
  Install Packer and make sure it's on your PATH.

  ### For initialize vpc terraform run
  ### Create remote terraform state for vpc network configuration
  ###  Create Main S3 bucket for terraform remote state and specific tfstate for each and DynamoDB tables for lock mechanism
  cd ./AWS/Homework3/vpc/remote_state
  terraform init
  terraform plan
  terraform apply --auto-approve
  
  ### Build network, subnets, routetables, Nat Gateways, Internet Gateway
  cd ..
  terraform init
  terraform plan
  terraform apply --auto-approve

  ### Create security tfstate and security DynamoDB table for lock mechanism
  cd ../Security/remote_state
  terraform init
  terraform plan
  terraform apply --auto-approve

  ### Build Security groups for web, db subnets and Public load balancer
  cd ..
  terraform init
  terraform plan
  terraform apply --auto-approve

  ### Create current packer template for current vpc1 public sub1 use
  cd ..
  ./shell/update_packer_template.sh
  ### Create web & db AMI images using packer
  packer build ./Packer/web/template.packer.current
  packer build ./Packer/db/template.packer.current
  \rm ./Packer/web/template.packer.current ./Packer/db/template.packer.current

  ### Create Instance & Load balncers tfstate and DynamoDB table for lock mechanism
  cd ../instances-n-lb/remote_state
  terraform init
  terraform plan
  terraform apply --auto-approve
  
  ### Build 2 Nginx servers, Public load balancer
  ### Build 2 mysql servers, Private load balancer
  cd ..
  terraform init
  terraform plan
  terraform apply --auto-approve   
  

## When you're done, run
terraform destroy -auto-approve
### The AWS AMI images that been created and the disks snapshot needs to delete manually
