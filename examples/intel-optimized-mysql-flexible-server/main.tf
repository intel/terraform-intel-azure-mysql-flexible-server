# Provision Intel Optimized Azure MySql server
module "optimized-mysql-server" {
  source              = "intel/azure-mysql-flexible-server/intel"
  resource_group_name = "resource_group_name"
  db_server_name      = "terraformtestingpoc01"
  db_password         = var.db_password
  tags = {
    name    = "name"
    purpose = "intel"
  }
  db_firewall_rules = [
    {
      name             = "Services"
      start_ip_address = "192.168.10.0"
      end_ip_address   = "192.168.10.50"
    }
  ]
}
