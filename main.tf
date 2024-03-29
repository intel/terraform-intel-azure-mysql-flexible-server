locals {
  # Determine if the db_engine is set to mysql. If true then create a list of all the backup strings, if false then create an empty list. This list is referenced to determine the length which acts like a flag for the dynamic block
  ha_flag = var.db_engine == "mysql" ? compact([var.db_ha_standby_zone, var.db_ha_mode]) : []

  # Evaluates if a parameter wasn't supplied in the input map (someone didn't want to use it) and returns only the objects that have been configured
  db_parameters = { for parameter, value in lookup(var.db_parameters, var.db_engine, {}) : parameter => value if value != null /* object */ }

  # Determine if the db_engine is set to mysql. If true then create a list of all the maintenance strings, if false then create an empty list. This list is referenced to determine the length which acts like a flag for the dynamic block
  maintenance_flag = var.db_engine == "mysql" ? compact([var.db_maintenance_day, var.db_maintenance_hour, var.db_maintenance_minute]) : []

  # Firewall rules that are converted from a list of a map. Setting the name of the rule to the key and reconstructing it so we can use for_each instead of count
  firewall_rules = {
    for rule, value in var.db_firewall_rules : value.name => {
      start_ip_address = value.start_ip_address
      end_ip_address   = value.end_ip_address
    }
  }
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.db_server_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  version             = var.db_engine_version
  sku_name            = var.db_server_sku

  # Authentication
  administrator_login    = var.db_create_mode != "Default" ? null : var.db_username
  administrator_password = var.db_create_mode != "Default" ? null : var.db_password

  zone                = var.db_zone
  private_dns_zone_id = var.db_private_dns_zone_id
  delegated_subnet_id = var.db_private_dns_zone_id != null ? var.db_delegated_subnet_id : null

  storage {
    auto_grow_enabled = local.ha_flag != null ? true : var.db_auto_grow_enabled
    iops              = var.db_iops
    size_gb           = var.db_allocated_storage
  }

  # Backups
  backup_retention_days        = var.db_backup_retention_period
  geo_redundant_backup_enabled = var.db_geo_backup_enabled

  # Create Mode
  create_mode                       = var.db_create_mode
  source_server_id                  = var.db_create_source_id
  point_in_time_restore_time_in_utc = var.db_create_mode == "PointInTimeRestore" && var.db_create_source_id != null ? var.db_restore_time : null
  replication_role                  = var.db_replica_role

  # High Availability
  dynamic "high_availability" {
    for_each = length(local.ha_flag) >= 1 ? { "ha_flag" : "" } : {}
    content {
      mode                      = var.db_ha_mode
      standby_availability_zone = var.db_ha_mode == "SameZone" ? var.db_zone : var.db_ha_standby_zone
    }
  }

  # Maintenance
  dynamic "maintenance_window" {
    for_each = length(local.maintenance_flag) >= 1 ? { "maintenance_flag" : "" } : {}
    content {
      day_of_week  = var.db_maintenance_day
      start_hour   = var.db_maintenance_hour
      start_minute = var.db_maintenance_minute
    }
  }

  # Tags
  tags = var.tags

  timeouts {
    create = var.db_timeouts.create
    delete = var.db_timeouts.delete
    update = var.db_timeouts.update
  }
}

resource "azurerm_mysql_flexible_server_configuration" "mysql" {
  for_each            = local.db_parameters
  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  value               = each.value.value
}

resource "azurerm_mysql_flexible_database" "mysql" {
  count               = var.db_name != null ? 1 : 0
  name                = var.db_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  resource_group_name = data.azurerm_resource_group.rg.name
  collation           = var.db_collation
  charset             = var.db_charset

  timeouts {
    create = var.db_timeouts.create
    delete = var.db_timeouts.delete
    #update = var.db_timeouts.update
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall" {
  for_each            = local.firewall_rules
  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}
