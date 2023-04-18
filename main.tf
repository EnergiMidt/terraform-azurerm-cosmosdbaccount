locals {
  name     = var.override_name == null ? "${var.system_name}-${lower(var.environment)}-cosmos" : var.override_name
  location = var.override_location == null ? var.resource_group.location : var.override_location

  cosmosdb_account = concat(azurerm_cosmosdb_account.cosmosdb_account[*], [null])[0]
}

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  count = var.enabled ? 1 : 0

  name                = local.name
  location            = local.location
  resource_group_name = var.resource_group.name

  offer_type = var.offer_type

  dynamic "analytical_storage" {
    for_each = var.analytical_storage_schema_type == null ? [] : [1]
    content {
      schema_type = var.analytical_storage_schema_type
    }
  }

  kind = var.kind

  enable_automatic_failover = var.enable_automatic_failover

  # checkov:skip=CKV_AZURE_99: The `public_network_access_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/ensure-cosmos-db-accounts-have-restricted-access
  # checkov:skip=CKV_AZURE_101: The `public_network_access_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/ensure-that-azure-cosmos-db-disables-public-network-access
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "consistency_policy" {
    for_each = lookup(var.configuration, "consistency_policy", {}) == {} ? [] : [1]

    content {
      consistency_level       = var.configuration.consistency_policy.consistency_level
      max_interval_in_seconds = try(var.configuration.consistency_policy.max_interval_in_seconds, null)
      max_staleness_prefix    = try(var.configuration.consistency_policy.max_staleness_prefix, null)
    }
  }

  dynamic "geo_location" {
    for_each = var.configuration.geo_locations

    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = try(geo_location.value.zone_redundant, null)
    }
  }

  dynamic "capabilities" {
    for_each = try(toset(var.configuration.capabilities), [])

    content {
      name = capabilities.value
    }
  }

  # checkov:skip=CKV_AZURE_100: The `key_vault_key_id` variable is optional by default.
  # https://docs.bridgecrew.io/docs/ensure-that-cosmos-db-accounts-have-customer-managed-keys-to-encrypt-data-at-rest
  key_vault_key_id = var.key_vault_key_id

  # checkov:skip=CKV_AZURE_132: The `access_key_metadata_writes_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/bc_azr_storage_4
  access_key_metadata_writes_enabled = var.access_key_metadata_writes_enabled

  mongo_server_version = var.mongo_server_version

  # checkov:skip=CKV_AZURE_140: The `local_authentication_disabled` variable defaults to false.
  # https://docs.bridgecrew.io/docs/ensure-azure-cosmosdb-has-local-authentication-disabled
  local_authentication_disabled = var.local_authentication_disabled

  tags = var.tags
}
