#AZURE HA
## Create Azure vnet remote state
cd remote_state;
terraform init;
terraform validate;
terraform plan -out vnet.tfplan;
terraform apply vnet.tfplan --auto-approve

## Create vnet & subnets
cd ..;
terraform init -backend-config=backend-config.txt;


