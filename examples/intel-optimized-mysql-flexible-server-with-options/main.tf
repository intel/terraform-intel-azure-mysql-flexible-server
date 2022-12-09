# Provision Intel Optimized Azure MySql server
module "optimized-mysql-server" {
  source              = "intel/azure-mysql-flexible-server/intel"
  resource_group_name = "mysql-resource-group-name" # Required
  db_server_name      = "mysql-test-22"             # Required
  db_password         = var.db_password             # Required
  db_ha_mode          = "SameZone"                  # Optional
  db_name             = "test-db"                   # Optional
  tags = {
    name    = "name"
    purpose = "intel"
  }
  db_firewall_rules = [
    {
      end_ip_address   = "0.0.0.0"
      name             = "Azure-All-Services"
      start_ip_address = "0.0.0.0"
    },
    {
      end_ip_address   = "172.16.1.254"
      name             = "Test-Rule"
      start_ip_address = "172.16.1.1"
    }
  ]
}

