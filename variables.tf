variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Possible values are dev, test, and prod."
  }
}

# This `name` variable is replaced by the use of `system_name` and `environment` variables.
# variable "name" {
#   description = "(Required) The name which should be used for this resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "system_name" {
  description = "(Required) The systen name which should be used for this resource. Changing this forces a new resource to be created."
  type        = string
}

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "override_location" {
  description = "(Optional) Override the location of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "resource_group" {
  description = "(Required) The resource group in which to create the resource."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) The location where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

variable "offer_type" {
  description = "(Optional) Specifies the Offer Type to use for this CosmosDB Account. Currently, this option can only be set to `Standard`."
  default     = "Standard"
  type        = string
  validation {
    condition     = can(regex("^(Standard)$", var.offer_type))
    error_message = "Possible values are Standard."
  }
}

variable "analytical_storage_schema_type" {
  description = "(Optional) The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`."
  type        = string
  default     = null
}

# variable "capacity" {}               # TODO: Implement this variable block.
# variable "create_mode" {}            # TODO: Implement this variable block.
# variable "default_identity_type" {} # TODO: Implement this variable block.

variable "kind" {
  description = "(Optional) Specifies the Kind of CosmosDB to create. Possible values are GlobalDocumentDB and MongoDB. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created."
  default     = "GlobalDocumentDB"
  type        = string
}

# variable "ip_range_filter" {} # TODO: Implement this variable block.
# variable "enable_free_tier" {} # TODO: Implement this variable block.
# variable "analytical_storage_enabled" {} # TODO: Implement this variable block.

variable "enable_automatic_failover" {
  description = "(Optional) Enable automatic fail over for this Cosmos DB account."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  # checkov:skip=CKV_AZURE_99: The `public_network_access_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/ensure-cosmos-db-accounts-have-restricted-access
  # checkov:skip=CKV_AZURE_101: The `public_network_access_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/ensure-that-azure-cosmos-db-disables-public-network-access
  description = "(Optional) Whether or not public network access is allowed for this CosmosDB account."
  default     = true
  type        = bool
}

variable "enabled" {
  description = "(Optional) Enable the creation of this Cosmos DB account."
  type        = bool
  default     = true
}

variable "configuration" {
  description = "(Optional) The configuration for block type arguments."
  type        = any
  default = {
    consistency_policy = {
      consistency_level       = "Session"
      max_interval_in_seconds = 5,
      max_staleness_prefix    = 100
    },
    geo_locations = {
      primary_geo_location = {
        location          = "AzureLocation"
        failover_priority = 0,
        zone_redundant    = false
      }
    }
  }
}

# variable "is_virtual_network_filter_enabled" {} # TODO: Implement this variable block.

variable "key_vault_key_id" {
  # checkov:skip=CKV_AZURE_100: The `key_vault_key_id` variable is optional by default.
  # https://docs.bridgecrew.io/docs/ensure-that-cosmos-db-accounts-have-customer-managed-keys-to-encrypt-data-at-rest
  description = "(Optional) A versionless Key Vault Key ID for CMK encryption. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

# variable "virtual_network_rule" {} # TODO: Implement this variable block.
# variable "enable_multiple_write_locations" {} # TODO: Implement this variable block.

variable "access_key_metadata_writes_enabled" {
  # checkov:skip=CKV_AZURE_132: The `access_key_metadata_writes_enabled` variable defaults to true.
  # https://docs.bridgecrew.io/docs/bc_azr_storage_4
  description = "(Optional) Is write operations on metadata resources (databases, containers, throughput) via account keys enabled? Defaults to `true`."
  type        = bool
  default     = true
}

# variable "mongo_server_version" {} # TODO: Implement this variable block.
# variable "network_acl_bypass_for_azure_services" {} # TODO: Implement this variable block.

variable "local_authentication_disabled" {
  # checkov:skip=CKV_AZURE_140: The `local_authentication_disabled` variable defaults to false.
  # https://docs.bridgecrew.io/docs/ensure-azure-cosmosdb-has-local-authentication-disabled
  description = "(Optional) Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Defaults to `false`. Can be set only when using the SQL API."
  type        = bool
  default     = false
}

# variable "backup" {} # TODO: Implement this variable block.
# variable "cors_rule" {} # TODO: Implement this variable block.
# variable "identity" {} # TODO: Implement this variable block.
# variable "restore" {} # TODO: Implement this variable block.

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null # {}
}
