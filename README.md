<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

## Azure MySQL Flexible Server Module 
This module can be used to deploy an Intel optimized Azure MySQL Flexible Server instance. 
Instance selection and mysql optimization are included by default in the code.

The MySQL Optimizations were based off [Intel Xeon Tunning guides](<https://www.intel.com/content/www/us/en/developer/articles/guide/open-source-database-tuning-guide-on-xeon-systems.html>)




## Usage

See examples folder for code ./examples/main.tf



By default, you will only have to pass four variables

```hcl
resource_group_name 
pgsql_server_name  
pgsql_db_name 
pgsql_administrator_login_password 


```

Example of Error:
->>> If you see this error message below, this is because the pgsql_server_name already exist and the user needs to provide different unique pgsql_server_name.
```hcl 
Error Message ::: " Server Name: "optimized-pgsql-server"): polling after Create: Code="ServerGroupDropping" Message="Operations on a server group in dropping state are not allowed."

```

Example of main.tf
```hcl
# main.tf

variable "mssql_administrator_login_password" {
  description = "The admin password"
}

# Provision Intel Optimized Azure PostgreSQL server 
module "optimized-pgsql-server" {
  source                             = "../../"                                                        #add the github url later
  resource_group_name                = "ENTER_RG_NAME_HERE"
  pgsql_server_name                  = "ENTER_PGSQL_SERVER_NAME_HERE"
  pgsql_db_name                      = "ENTER_PGSQL_DB_NAME_HERE"
  pgsql_administrator_login_password = var.pgsql_administrator_login_password
  tags                               = {"ENTER_TAG_KEY" = "ENTER_TAG_VALUE", ... }                      #Can add tags as key-value pair (Optional)

  #firewall_ip_ranges                                                                                   #Can add firewall rules (Optional)
  #For example: " [{start_ip_address = ..., end_ip_address = ... },..]"                                
  firewall_ip_range                  =  [
                                            {start_ip_address = "ENTER_START_IP_ADDRESS_HERE", end_ip_address = "ENTER_END_IP_ADDRESS_HERE" },...
                                       ]
}



```
Run terraform
```
terraform init  
terraform plan -var="pgsql_administrator_login_password=..." #Enter a complex password
terraform apply -var="pgsql_administrator_login_password=..." #Enter a complex password

```
## Considerations
This module further provides the ability to add firewall_ip_range (Usage Example provided above). For more information [azurerm_postgresql_flexible_server_firewall_rule](<https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule>)



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mysql_flexible_database.mysql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.mysql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.mysql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage) | Maximum allocated storage for Azure database instance to grow (in gigabytes). | `number` | `2048` | no |
| <a name="input_db_auto_grow_enabled"></a> [db\_auto\_grow\_enabled](#input\_db\_auto\_grow\_enabled) | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. | `bool` | `true` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | The days to retain backups for. Must be between 1 and 35. | `number` | `7` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Specifies the Charset for the MySQL Database. | `string` | `"utf8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Specifies the Collation for the MySQL Database. | `string` | `"utf8_general_ci"` | no |
| <a name="input_db_create_mode"></a> [db\_create\_mode](#input\_db\_create\_mode) | The creation mode which can be used to restore or replicate existing servers. | `string` | `"Default"` | no |
| <a name="input_db_create_source_id"></a> [db\_create\_source\_id](#input\_db\_create\_source\_id) | For creation modes other than Default, the source server ID to use. | `string` | `null` | no |
| <a name="input_db_delegated_subnet_id"></a> [db\_delegated\_subnet\_id](#input\_db\_delegated\_subnet\_id) | The ID of the virtual network subnet to create the MySQL Flexible Server. | `string` | `null` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | Database engine for Azure database instance. | `string` | `"mysql"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | Database engine version for the Azure database instance. | `string` | `"8.0.21"` | no |
| <a name="input_db_firewall_rules"></a> [db\_firewall\_rules](#input\_db\_firewall\_rules) | Map of IP ranges that (if specified) will create firewall rules for the MySQL server to access those addresses. | <pre>list(object({<br>    name             = string<br>    start_ip_address = optional(string)<br>    end_ip_address   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_db_geo_backup_enabled"></a> [db\_geo\_backup\_enabled](#input\_db\_geo\_backup\_enabled) | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster | `bool` | `false` | no |
| <a name="input_db_ha_mode"></a> [db\_ha\_mode](#input\_db\_ha\_mode) | The high availability mode for the MySQL Flexible Server. Possibles values are SameZone and ZoneRedundant. | `string` | `"ZoneRedundant"` | no |
| <a name="input_db_ha_standby_zone"></a> [db\_ha\_standby\_zone](#input\_db\_ha\_standby\_zone) | Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are 1, 2 and 3. | `string` | `null` | no |
| <a name="input_db_iops"></a> [db\_iops](#input\_db\_iops) | The amount of provisioned IOPS. | `number` | `10000` | no |
| <a name="input_db_maintenance_day"></a> [db\_maintenance\_day](#input\_db\_maintenance\_day) | The day of week for maintenance window. | `string` | `null` | no |
| <a name="input_db_maintenance_hour"></a> [db\_maintenance\_hour](#input\_db\_maintenance\_hour) | The start hour for maintenance window. | `string` | `null` | no |
| <a name="input_db_maintenance_minute"></a> [db\_maintenance\_minute](#input\_db\_maintenance\_minute) | The start minute for maintenance window. | `string` | `null` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the database that will be created on the flexible instance. If this is specified then a database will be created as a part of the instance provisioning process. | `string` | `null` | no |
| <a name="input_db_parameters"></a> [db\_parameters](#input\_db\_parameters) | n/a | <pre>object({<br>    mysql = optional(object({<br>      table_open_cache = optional(object({<br>        value = optional(string, "8000")<br>      }))<br>      table_open_cache_instances = optional(object({<br>        value = optional(string, "16")<br>      }))<br>      # Doesn't work on 8.x<br>      # max_connections = optional(object({<br>      #   value = optional(string, "4000")<br>      # }))<br>      # Read Only<br>      # back_log = optional(object({<br>      #   value = optional(string, "1500")<br>      # }))<br>      # Read Only<br>      # default_password_lifetime = optional(object({<br>      #   value = optional(string, "0")<br>      # }))<br>      performance_schema = optional(object({<br>        value = optional(string, "OFF")<br>      }))<br>      max_prepared_stmt_count = optional(object({<br>        value = optional(string, "128000")<br>      }))<br>      character_set_server = optional(object({<br>        value = optional(string, "latin1")<br>      }))<br>      collation_server = optional(object({<br>        value = optional(string, "latin1_swedish_ci")<br>      }))<br>      transaction_isolation = optional(object({<br>        value = optional(string, "REPEATABLE-READ")<br>      }))<br>      innodb_log_file_size = optional(object({<br>        value = optional(string, 1024 * 1024 * 1024)<br>      }))<br>      # Doesn't work on 8.x<br>      # innodb_buffer_pool_size = optional(object({<br>      #   value = optional(string, 64424509440)<br>      # }))<br>      innodb_open_files = optional(object({<br>        value = optional(string, "4000")<br>      }))<br>      innodb_file_per_table = optional(object({<br>        value = optional(string, "ON")<br>      }))<br>      # Read Only<br>      # innodb_buffer_pool_instances = optional(object({<br>      #   value = optional(string, "16")<br>      # }))<br>      innodb_log_buffer_size = optional(object({<br>        value = optional(string, "67108864")<br>      }))<br>      innodb_thread_concurrency = optional(object({<br>        value = optional(string, "0")<br>      }))<br>      # Read Only<br>      # innodb_flush_log_at_trx_commit = optional(object({<br>      #   value = optional(string, "0")<br>      # }))<br>      innodb_max_dirty_pages_pct = optional(object({<br>        value = optional(string, "90")<br>      }))<br>      innodb_max_dirty_pages_pct_lwm = optional(object({<br>        value = optional(string, "10")<br>      }))<br>      join_buffer_size = optional(object({<br>        value = optional(string, 32 * 1024)<br>      }))<br>      sort_buffer_size = optional(object({<br>        value = optional(string, 32 * 1024)<br>      }))<br>      # Read Only<br>      # innodb_use_native_aio = optional(object({<br>      #   value = optional(string, "1")<br>      # }))<br>      innodb_stats_persistent = optional(object({<br>        value = optional(string, "ON")<br>      }))<br>      innodb_spin_wait_delay = optional(object({<br>        value = optional(string, "6")<br>      }))<br>      innodb_max_purge_lag_delay = optional(object({<br>        value = optional(string, "300000")<br>      }))<br>      innodb_max_purge_lag = optional(object({<br>        value = optional(string, "0")<br>      }))<br>      # Read Only<br>      # innodb_checksum_algorithm = optional(object({<br>      #   value = optional(string, "none")<br>      # }))<br>      innodb_io_capacity = optional(object({<br>        value = optional(string, "4000")<br>      }))<br>      innodb_io_capacity_max = optional(object({<br>        value = optional(string, "20000")<br>      }))<br>      innodb_lru_scan_depth = optional(object({<br>        value = optional(string, "9000")<br>      }))<br>      innodb_change_buffering = optional(object({<br>        value = optional(string, "none")<br>      }))<br>      innodb_page_cleaners = optional(object({<br>        value = optional(string, "4")<br>      }))<br>      # Read Only<br>      # innodb_undo_log_truncate = optional(object({<br>      #   value = optional(string, "0")<br>      # }))<br>      innodb_adaptive_flushing = optional(object({<br>        value = optional(string, "ON")<br>      }))<br>      innodb_flush_neighbors = optional(object({<br>        value = optional(string, "0")<br>      }))<br>      innodb_read_io_threads = optional(object({<br>        value = optional(string, "16")<br>      }))<br>      innodb_write_io_threads = optional(object({<br>        value = optional(string, "16")<br>      }))<br>      innodb_purge_threads = optional(object({<br>        value = optional(string, "4")<br>      }))<br>      innodb_adaptive_hash_index = optional(object({<br>        value = optional(string, "OFF")<br>      }))<br>    }))<br>  })</pre> | <pre>{<br>  "mysql": {<br>    "character_set_server": {},<br>    "collation_server": {},<br>    "innodb_adaptive_flushing": {},<br>    "innodb_adaptive_hash_index": {},<br>    "innodb_change_buffering": {},<br>    "innodb_file_per_table": {},<br>    "innodb_flush_neighbors": {},<br>    "innodb_io_capacity": {},<br>    "innodb_io_capacity_max": {},<br>    "innodb_log_buffer_size": {},<br>    "innodb_log_file_size": {},<br>    "innodb_lru_scan_depth": {},<br>    "innodb_max_dirty_pages_pct": {},<br>    "innodb_max_dirty_pages_pct_lwm": {},<br>    "innodb_max_purge_lag": {},<br>    "innodb_max_purge_lag_delay": {},<br>    "innodb_open_files": {},<br>    "innodb_page_cleaners": {},<br>    "innodb_purge_threads": {},<br>    "innodb_read_io_threads": {},<br>    "innodb_spin_wait_delay": {},<br>    "innodb_stats_persistent": {},<br>    "innodb_thread_concurrency": {},<br>    "innodb_write_io_threads": {},<br>    "join_buffer_size": {},<br>    "max_prepared_stmt_count": {},<br>    "performance_schema": {},<br>    "sort_buffer_size": {},<br>    "table_open_cache": {},<br>    "table_open_cache_instances": {},<br>    "transaction_isolation": {}<br>  }<br>}</pre> | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the master database user. | `string` | n/a | yes |
| <a name="input_db_private_dns_zone_id"></a> [db\_private\_dns\_zone\_id](#input\_db\_private\_dns\_zone\_id) | The ID of the private DNS zone to create the MySQL Flexible Server. | `string` | `null` | no |
| <a name="input_db_replica_role"></a> [db\_replica\_role](#input\_db\_replica\_role) | The replica role that the database will use. | `string` | `null` | no |
| <a name="input_db_restore_time"></a> [db\_restore\_time](#input\_db\_restore\_time) | When create\_mode is PointInTimeRestore, specifies the point in time to restore from creation\_source\_server\_id. It should be provided in RFC3339 format, e.g. 2013-11-08T22:00:40Z. | `string` | `null` | no |
| <a name="input_db_server_name"></a> [db\_server\_name](#input\_db\_server\_name) | Name of the server that will be created. | `string` | n/a | yes |
| <a name="input_db_server_sku"></a> [db\_server\_sku](#input\_db\_server\_sku) | Instance SKU, see comments above for guidance | `string` | `"MO_Standard_E8ds_v5"` | no |
| <a name="input_db_timeouts"></a> [db\_timeouts](#input\_db\_timeouts) | Map of timeouts that can be adjusted when executing the module. This allows you to customize how long certain operations are allowed to take before being considered to have failed. | <pre>object({<br>    create = optional(string, null)<br>    delete = optional(string, null)<br>    update = optional(string, null)<br>  })</pre> | <pre>{<br>  "db_timeouts": {}<br>}</pre> | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the master database user. | `string` | `"mysqladmin"` | no |
| <a name="input_db_zone"></a> [db\_zone](#input\_db\_zone) | Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group where resource will be created. It should already exist | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Database Server | `map(string)` | `{}` | no |

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