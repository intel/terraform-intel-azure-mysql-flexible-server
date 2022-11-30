<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

## Azure MySQL Flexible Server Module 
This module can be used to deploy an Intel optimized Azure MySQL Flexible Server instance. 
Instance selection and mysql optimization are included by default in the code.

The MySQL Optimizations were based off [Intel Xeon Tunning guides](<https://www.intel.com/content/www/us/en/developer/articles/guide/open-source-database-tuning-guide-on-xeon-systems.html>)

## Usage

**See examples folder for complete examples.**

By default, you will only have to pass three variables

```hcl
resource_group_name    
db_server_name       
db_password         
```

variables.tf

```hcl
variable "db_password" {
  description = "Password for the master database user."
  type        = string
  sensitive   = true
}
```

main.tf

```hcl
module "optimized-mysql-server" {
  source          = "github.com/intel/terraform-intel-azure-mysql_flexible_server"
  resource_group_name = "<RESOURCE_GROUP_NAME>"   
  db_server_name      = "<DB_SERVER_NAME>" 
  db_password         = var.db_password
}
```

Run Terraform

```hcl
export TF_VAR_db_password ='<USE_A_STRONG_PASSWORD>'

terraform init  
terraform plan
terraform apply 
```

Note that this example creates resources. Run `terraform destroy` when you don't need these resources.


<!-- BEGIN_TF_DOCS -->


<!-- END_TF_DOCS -->