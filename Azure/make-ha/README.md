#AZURE HA
##### Create Azure vnet remote state
cd remote_state;
terraform init;
terraform validate;
terraform plan -out vnet.remotestate.tfplan;
terraform apply --auto-approve vnet.remotestate.tfplan

##### Create vnet & subnets
cd ..;
terraform init -backend=true -backend-config=./backend-config.txt;
terraform validate;
terraform plan -out vnet.tfplan;
terraform apply --auto-approve vnet.tfplan

