#AZURE HA
##### Create Azure vnet remote state
cd remote_state;
terraform init;
terraform validate;
terraform plan -out vnet.remotestate.tvplan;
terraform apply --auto-approve vnet.remotestate.tvplan

##### Create vnet & subnets
cd ..;
terraform init -backend=true -backend-config=./backend-config.txt;
terraform validate;
terraform plan -out vnet.tvplan;
terraform apply --auto-approve vnet.tvplan

