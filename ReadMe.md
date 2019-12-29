# About

Script to create 3 private subnets, NAT, Route Table in an existing VPC


## Steps to run this

1. Install Terraform cli
2. Clone this Repo
3. Create Config file <account>.tfvars
4. Commands:
 ```
 terraform init
 terraform get 
 terraform plan -var-file="filename.tfvars"
 terraform apply -var-file="filename.tfvars"
 ```

### Further Reading
https://www.terraform.io/docs/configuration/variables.html#variable-definition-precedence