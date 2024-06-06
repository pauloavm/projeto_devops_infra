output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "sql_server_name" {
  value = azurerm_sql_server.sql.name
}
