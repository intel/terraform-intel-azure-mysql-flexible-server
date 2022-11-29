#PostgreSQL Sever SKU
# See policies.md, Intel recommends the Eds_v5-series running on the 3rd Generation Intel® Xeon® Platinum 8370C (Ice Lake) scalable procesors. 
# Memory Optimized: MO_Standard_E2ds_v5, MO_Standard_E4ds_v5, MO_Standard_E8ds_v5, MO_Standard_E16ds_v5, MO_Standard_E20ds_v5, MO_Standard_E32ds_v5,MO_Standard_E48ds_v5, MO_Standard_E64ds_v5
# The number between E and d in MO_Standard_E8ds_v5 stands for vCores. 
# Ex.: MO_Standard_E8ds_v5-> 8 stands for vCPU count
# See more:
# https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage
variable "db_server_sku" {
  description = "Instance SKU, see comments above for guidance"
  type        = string
  default     = "MO_Standard_E8ds_v5"
}

variable "db_parameters" {
  type = object({
    mysql = optional(object({
      table_open_cache = optional(object({
        value = optional(string, "8000")
      }))
      table_open_cache_instances = optional(object({
        value = optional(string, "16")
      }))
      performance_schema = optional(object({
        value = optional(string, "OFF")
      }))
      max_prepared_stmt_count = optional(object({
        value = optional(string, "128000")
      }))
      character_set_server = optional(object({
        value = optional(string, "latin1")
      }))
      collation_server = optional(object({
        value = optional(string, "latin1_swedish_ci")
      }))
      transaction_isolation = optional(object({
        value = optional(string, "REPEATABLE-READ")
      }))
      innodb_log_file_size = optional(object({
        value = optional(string, 1024 * 1024 * 1024)
      }))
      innodb_open_files = optional(object({
        value = optional(string, "4000")
      }))
      innodb_file_per_table = optional(object({
        value = optional(string, "ON")
      }))
      innodb_log_buffer_size = optional(object({
        value = optional(string, "67108864")
      }))
      innodb_thread_concurrency = optional(object({
        value = optional(string, "0")
      }))
      innodb_max_dirty_pages_pct = optional(object({
        value = optional(string, "90")
      }))
      innodb_max_dirty_pages_pct_lwm = optional(object({
        value = optional(string, "10")
      }))
      join_buffer_size = optional(object({
        value = optional(string, 32 * 1024)
      }))
      sort_buffer_size = optional(object({
        value = optional(string, 32 * 1024)
      }))
      innodb_stats_persistent = optional(object({
        value = optional(string, "ON")
      }))
      innodb_spin_wait_delay = optional(object({
        value = optional(string, "6")
      }))
      innodb_max_purge_lag_delay = optional(object({
        value = optional(string, "300000")
      }))
      innodb_max_purge_lag = optional(object({
        value = optional(string, "0")
      }))
      innodb_io_capacity = optional(object({
        value = optional(string, "4000")
      }))
      innodb_io_capacity_max = optional(object({
        value = optional(string, "20000")
      }))
      innodb_lru_scan_depth = optional(object({
        value = optional(string, "9000")
      }))
      innodb_change_buffering = optional(object({
        value = optional(string, "none")
      }))
      innodb_page_cleaners = optional(object({
        value = optional(string, "4")
      }))
      innodb_adaptive_flushing = optional(object({
        value = optional(string, "ON")
      }))
      innodb_flush_neighbors = optional(object({
        value = optional(string, "0")
      }))
      innodb_read_io_threads = optional(object({
        value = optional(string, "16")
      }))
      innodb_write_io_threads = optional(object({
        value = optional(string, "16")
      }))
      innodb_purge_threads = optional(object({
        value = optional(string, "4")
      }))
      innodb_adaptive_hash_index = optional(object({
        value = optional(string, "OFF")
      }))
    }))
  })
  default = {
    mysql = {
      character_set_server           = {}
      collation_server               = {}
      innodb_adaptive_flushing       = {}
      innodb_adaptive_hash_index     = {}
      innodb_change_buffering        = {}
      innodb_file_per_table          = {}
      innodb_flush_neighbors         = {}
      innodb_io_capacity             = {}
      innodb_io_capacity_max         = {}
      innodb_log_buffer_size         = {}
      innodb_log_file_size           = {}
      innodb_lru_scan_depth          = {}
      innodb_max_dirty_pages_pct     = {}
      innodb_max_dirty_pages_pct_lwm = {}
      innodb_max_purge_lag           = {}
      innodb_max_purge_lag_delay     = {}
      innodb_open_files              = {}
      innodb_page_cleaners           = {}
      innodb_purge_threads           = {}
      innodb_read_io_threads         = {}
      innodb_spin_wait_delay         = {}
      innodb_stats_persistent        = {}
      innodb_thread_concurrency      = {}
      innodb_write_io_threads        = {}
      join_buffer_size               = {}
      max_prepared_stmt_count        = {}
      performance_schema             = {}
      sort_buffer_size               = {}
      table_open_cache               = {}
      table_open_cache_instances     = {}
      transaction_isolation          = {}
    }
  }
  description = "Intel Cloud optimizations for Xeon processors"
     
      # Doesn't work on 8.x
      # innodb_buffer_pool_size = optional(object({
      #   value = optional(string, 64424509440)
      # }))
      # Doesn't work on 8.x
      # max_connections = optional(object({
      #   value = optional(string, "4000")
      # }))
      /* This parameter is READ-Only in Azure Portal with Defaults given below*/
      # Read Only
      # back_log = optional(object({
      #   value = optional(string, "1500")
      # }))
      # Read Only
      # default_password_lifetime = optional(object({
      #   value = optional(string, "0")
      # }))
      # Read Only
      # innodb_buffer_pool_instances = optional(object({
      #   value = optional(string, "16")
      # }))
      # Read Only
      # innodb_flush_log_at_trx_commit = optional(object({
      #   value = optional(string, "0")
      # }))
      # Read Only
      # innodb_use_native_aio = optional(object({
      #   value = optional(string, "1")
      # }))
      # Read Only
      # innodb_undo_log_truncate = optional(object({
      #   value = optional(string, "0")
      # }))
      # Read Only
      # innodb_checksum_algorithm = optional(object({
      #   value = optional(string, "none")
      # }))
}

########################
####    Required    ####
########################
variable "db_password" {
  description = "Password for the master database user."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8
    error_message = "The db_password value must be at least 8 characters in length."
  }
}

variable "db_server_name" {
  description = "Name of the server that will be created."
  type        = string
}

# REQUIRED - Resource Group Name
variable "resource_group_name" {
  description = "Resource Group where resource will be created. It should already exist"
  type        = string
}

########################
####     Other      ####
########################
variable "db_username" {
  description = "Username for the master database user."
  type        = string
  default     = "mysqladmin"
}

variable "db_zone" {
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  type        = string
  default     = 1
}

variable "db_ha_standby_zone" {
  description = "Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are 1, 2 and 3."
  type        = string
  default     = 2
}

variable "db_ha_mode" {
  description = "The high availability mode for the MySQL Flexible Server. Possibles values are SameZone and ZoneRedundant."
  type        = string
  default     = "ZoneRedundant"
}

# Backups
variable "db_backup_retention_period" {
  description = "The days to retain backups for. Must be between 1 and 35."
  type        = number
  validation {
    condition     = var.db_backup_retention_period >= 1 && var.db_backup_retention_period <= 35
    error_message = "The db_backup_retention_period must be null or if specified between 7 and 35."
  }
  default = 7
}

variable "db_geo_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster"
  type        = bool
  default     = false
}

variable "db_replica_role" {
  description = "The replica role that the database will use."
  type        = string
  default     = null
}

variable "db_allocated_storage" {
  description = "Maximum allocated storage for Azure database instance to grow (in gigabytes)."
  type        = number
  default     = 2048
}

variable "db_auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only."
  type        = bool
  default     = true
}

variable "db_create_mode" {
  description = "The creation mode which can be used to restore or replicate existing servers."
  type        = string
  validation {
    condition     = contains(["Default", "Replica", "GeoRestore", "PointInTimeRestore"], var.db_create_mode)
    error_message = "The db_create_mode must be \"Default\",\"Replica\",\"GeoRestore\", or \"PointInTimeRestore\"."
  }
  default = "Default"
}

variable "db_create_source_id" {
  description = "For creation modes other than Default, the source server ID to use."
  type        = string
  default     = null
}

variable "db_name" {
  description = "Name of the database that will be created on the flexible instance. If this is specified then a database will be created as a part of the instance provisioning process."
  type        = string
  default     = null
}

variable "db_engine_version" {
  description = "Database engine version for the Azure database instance."
  type        = string
  default = "8.0.21"
}

variable "db_restore_time" {
  description = "When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id. It should be provided in RFC3339 format, e.g. 2013-11-08T22:00:40Z."
  type        = string
  default     = null
}

variable "db_iops" {
  description = "The amount of provisioned IOPS."
  type        = number
  default     = 10000
}

variable "db_collation" {
  description = "Specifies the Collation for the MySQL Database."
  type        = string
  default     = "utf8_general_ci"
}

variable "db_charset" {
  description = "Specifies the Charset for the MySQL Database."
  type        = string
  default     = "utf8"
}

variable "db_private_dns_zone_id" {
  description = "The ID of the private DNS zone to create the MySQL Flexible Server."
  type        = string
  default     = null
}

variable "db_delegated_subnet_id" {
  description = "The ID of the virtual network subnet to create the MySQL Flexible Server."
  type        = string
  default     = null
}

variable "db_timeouts" {
  type = object({
    create = optional(string, null)
    delete = optional(string, null)
    update = optional(string, null)
  })
  description = "Map of timeouts that can be adjusted when executing the module. This allows you to customize how long certain operations are allowed to take before being considered to have failed."
  default = {
    db_timeouts = {}
  }
}

variable "db_engine" {
  description = "Database engine for Azure database instance."
  type        = string
  validation {
    condition     = contains(["mysql"], var.db_engine)
    error_message = "The db_engine must be \"mysql\"."
  }
  default = "mysql"
}

variable "tags" {
  description = "Tags to apply to the Database Server"
  type        = map(string)
  default     = {}
}

variable "db_maintenance_day" {
  description = "The day of week for maintenance window."
  type        = string
  default     = null
}

variable "db_maintenance_hour" {
  description = "The start hour for maintenance window."
  type        = string
  default     = null
}

variable "db_maintenance_minute" {
  description = "The start minute for maintenance window."
  type        = string
  default     = null
}

variable "db_firewall_rules" {
  description = "Map of IP ranges that (if specified) will create firewall rules for the MySQL server to access those addresses."
  type = list(object({
    name             = string
    start_ip_address = optional(string)
    end_ip_address   = optional(string)
  }))
  default = []
}