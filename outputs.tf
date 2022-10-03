output "azurerm_cosmosdb_account" {
  description = "The Azure CosmosDB Account resource."
  value       = local.cosmosdb_account
}

output "azurerm_cosmosdb_account_id" {
  description = "The ID of Azure CosmosDB Account resource."
  value       = local.cosmosdb_account.id
}
