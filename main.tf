resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  
  tags = {
    environment = "Dev"
    costcenter  = "IT"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_sql_server" "sql" {
  name                         = "sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "H@Sh1CoR3!"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "maindb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  server_name         = azurerm_sql_server.sql.name
  edition             = "Basic"
}
