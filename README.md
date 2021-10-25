# Terraform Infrastructure
The terraform scripts and bash files will create an infrastructure that will contain the following components and services at
this moment. A VPC that will in eu-central-1 region with 4 subnets in 2 different AZ. One private and one public subnet in
each AZ. Two instances will be created in a public subnet in the first AZ(eu-central-1a) and 1 instance and 1 RDS on the
private subnet. In addition a S3 Bucket will be created. All the proper configurations such as security groups, subnet groups,
route tables, etc. are included (except for the connection remotely to RDS). 

## Steps to deploy the infrastructure
1. After cloning the repository, change directory into it and create a folder called "keys", and create the keys.
```bash
mkdir keys
cd keys
ssh-keygen -f publickey
ssh-add publickey
ssh-keygen -f privatekey
ssh-add privatekey
```  
2. After creating the keys, run the aws_config.sh script. This will install the AWS CLI and prompt necessary input such as 
secret access key and access key id. After, it will initiate terraform, plan the script with the output 'terraformPlan.json'.
Finally it will apply the terraform scripts.
```bash
bash aws_config.sh
``` 
## Steps to connect to the instances: SSH
1. Go to .ssh folder in your home directory and create a config file.
```bash
cd ~/.ssh/
nano config
``` 
2. Copy the config example text to the config file and modify accordingly (IPs will be given once the instances are launched).
3. To connect through ssh now just use the name of the hosts for example:
```bash
ssh bastion
ssh backend
ssh webserver
```
4. To connect to the RDS first connect to the bastion host through ssh and then use mysql client to connect to the RDS instance.
```bash
ssh bastion
mysql -u username -h rds.entrypoint -P 3306 -p
``` 
 
##Conclusion
Ye! Will add later!
