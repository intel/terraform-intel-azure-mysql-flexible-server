<p align="center">
  <img src="https://github.com/intel/terraform-intel-azure-mysql-flexible-server/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## Azure MySQL Flexible Server Module - Database Parameters Example

This example creates an Intel optimized Azure MySQL Flexible Server database and optimizes the database parameters. The database instance is created on an Intel Icelake Eds_v5 by default. The database server is pre-configured with parameters within the database parameter group that is optimized for Intel architecture. The goal of this module is to get you started with a database configured to run best on Intel architecture.

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements.

This module can be used to deploy an Intel optimized Azure MySQL Flexible Server instance.

The MySQL Optimizations were based off [Intel Xeon Tunning guides](<https://www.intel.com/content/www/us/en/developer/articles/guide/open-source-database-tuning-guide-on-xeon-systems.html>)

## Usage

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
  source              = "intel/azure-mysql-flexible-server/intel"
  resource_group_name = "mysql-resource-group-name" # Required
  db_server_name      = "mysql-test-21"             # Required
  db_password         = var.db_password             # Required
  db_ha_mode          = "SameZone"                  # Optional
  db_name             = "test-db"                   # Optional
  tags = {
    name    = "name"
    purpose = "intel"
  }

  db_parameters = {
    mysql = {
      character_set_server = {
        value = "latin1"
      }
      collation_server = {
        value = "latin1_swedish_ci"
      }
      innodb_adaptive_flushing = {
        value = "ON"
      }
      innodb_adaptive_hash_index = {
        value = "OFF"
      }
    }
  }


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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.26.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_optimized-mysql-server"></a> [optimized-mysql-server](#module\_optimized-mysql-server) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the master database user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_allocated_storage"></a> [db\_allocated\_storage](#output\_db\_allocated\_storage) | Storage that was allocated to the instance when it configured. |
| <a name="output_db_auto_grow_enabled"></a> [db\_auto\_grow\_enabled](#output\_db\_auto\_grow\_enabled) | Flag that determines if storage auto grow is enabled. |
| <a name="output_db_backup_retention"></a> [db\_backup\_retention](#output\_db\_backup\_retention) | Number of configured backups to keep for the database instance. |
| <a name="output_db_charset"></a> [db\_charset](#output\_db\_charset) | The Charset configured on the database. |
| <a name="output_db_collation"></a> [db\_collation](#output\_db\_collation) | The Collation configured on the database. |
| <a name="output_db_create_mode"></a> [db\_create\_mode](#output\_db\_create\_mode) | The creation mode that was configured on the instance. |
| <a name="output_db_create_source_id"></a> [db\_create\_source\_id](#output\_db\_create\_source\_id) | For creation modes other than Default, the source server ID to use. |
| <a name="output_db_delegated_subnet_id"></a> [db\_delegated\_subnet\_id](#output\_db\_delegated\_subnet\_id) | The ID of the virtual network subnet to create the MySQL Flexible Server. |
| <a name="output_db_engine_version_actual"></a> [db\_engine\_version\_actual](#output\_db\_engine\_version\_actual) | Running engine version of the database (full version number) |
| <a name="output_db_firewall_rules"></a> [db\_firewall\_rules](#output\_db\_firewall\_rules) | Monitoring interval configuration. |
| <a name="output_db_ha_mode"></a> [db\_ha\_mode](#output\_db\_ha\_mode) | The high availability mode for the MySQL Flexible Server. |
| <a name="output_db_ha_standby_zone"></a> [db\_ha\_standby\_zone](#output\_db\_ha\_standby\_zone) | Specifies the Availability Zone in which the standby Flexible Server should be located. |
| <a name="output_db_hostname"></a> [db\_hostname](#output\_db\_hostname) | Database instance fully qualified domain name. |
| <a name="output_db_id"></a> [db\_id](#output\_db\_id) | Database instance ID. |
| <a name="output_db_iops"></a> [db\_iops](#output\_db\_iops) | Database instance iops that was configured. |
| <a name="output_db_location"></a> [db\_location](#output\_db\_location) | Database instance location. |
| <a name="output_db_maintenance_window_day"></a> [db\_maintenance\_window\_day](#output\_db\_maintenance\_window\_day) | Maintainence window for the database instance. |
| <a name="output_db_maintenance_window_hour"></a> [db\_maintenance\_window\_hour](#output\_db\_maintenance\_window\_hour) | Maintainence window for the database instance. |
| <a name="output_db_maintenance_window_minute"></a> [db\_maintenance\_window\_minute](#output\_db\_maintenance\_window\_minute) | Maintainence window for the database instance. |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Name of the database that has been provisioned on the database instance. |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | Database instance master password. |
| <a name="output_db_private_dns_zone_id"></a> [db\_private\_dns\_zone\_id](#output\_db\_private\_dns\_zone\_id) | The ID of the private DNS zone that the instance will use. |
| <a name="output_db_replica_role"></a> [db\_replica\_role](#output\_db\_replica\_role) | The replica role that the database was configured with. |
| <a name="output_db_resource_group_name"></a> [db\_resource\_group\_name](#output\_db\_resource\_group\_name) | Resource Group where the database instance resides. |
| <a name="output_db_restore_time"></a> [db\_restore\_time](#output\_db\_restore\_time) | Specifies the point in time to restore from creation\_source\_server\_id. |
| <a name="output_db_server_name"></a> [db\_server\_name](#output\_db\_server\_name) | Database instance hostname. |
| <a name="output_db_server_sku"></a> [db\_server\_sku](#output\_db\_server\_sku) | Instance SKU in use for the database instance that was created. |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | Database instance master username. |
| <a name="output_db_zone"></a> [db\_zone](#output\_db\_zone) | Zone where the database instance was deployed. |
<!-- END_TF_DOCS -->