# Provision Intel Optimized Azure MySql server
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

