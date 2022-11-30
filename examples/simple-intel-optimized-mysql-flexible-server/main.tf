# Provision Intel Optimized Azure MySql server
module "optimized-mysql-server" {
  source              = "../../"
  resource_group_name = "terraform-testing-rg"
  db_server_name      = "terraformtestingpoc01"
  db_password         = var.db_password
  db_firewall_rules = [
    {
      name             = "Services"
      start_ip_address = "192.168.10.0"
      end_ip_address   = "192.168.10.50"
    }
  ]
}
