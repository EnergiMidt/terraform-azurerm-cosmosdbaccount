variable "name" {
  description = "(Required) Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created."
  type        = string
}

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = ""
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Valid options are dev, test, and prod."
  }
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
#   type        = string
# }

variable "offer_type" {
  description = "(Optional) Specifies the Offer Type to use for this CosmosDB Account. Currently, this option can only be set to Standard."
  default     = "Standard"
  type        = string
}

variable "analytical_storage_schema_type" {
  description = "(Optional) The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`."
  type        = string
  default     = null
  validation {
    condition     = contains(["FullFidelity", "WellDefined"], var.analytical_storage_schema_type)
    error_message = "Possible values are `FullFidelity` and `WellDefined`."
  }
}

# variable "capacity" {}               # TODO: Implement this variable block.
# variable "create_mode" {}            # TODO: Implement this variable block.
# variable "default_identity_type" {} # TODO: Implement this variable block.

variable "kind" {
  description = "(Optional) Specifies the Kind of CosmosDB to create. Possible values are GlobalDocumentDB and MongoDB. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created."
  default     = "GlobalDocumentDB"
  type        = string
}

variable "consistency_policy_consistency_level" {
  description = "(Required) The Consistency Level to use for this CosmosDB Account. It can be either BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix."
  type        = string
}

variable "consistency_policy_max_interval_in_seconds" {
  description = "(Optional) When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is `5` - `86400` (1 day). Defaults to `5`. Required when `consistency_level` is set to `BoundedStaleness`."
  type        = number
  default     = 5
}

variable "consistency_policy_max_staleness_prefix" {
  description = "(Optional) When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is `10` – `2147483647`. Defaults to `100`. Required when `consistency_level` is set to `BoundedStaleness`."
  type        = number
  default     = 100
}

# This `consistency_policy` variable is replaced by the use of above `consistency_policy_*` variables.
# variable "consistency_policy" {
#   description = "(Required) Specifies a consistency_policy resource, used to define the consistency policy for this CosmosDB account."
# }

variable "geo_location_location" {
  description = "(Optional) The name of the Azure region to host replicated data."
  default     = ""
  type        = string
}

variable "geo_location_failover_priority" {
  description = "(Optional) The failover priority of the region. A failover priority of `0` indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority `0`."
  default     = 0
  type        = number
}

variable "geo_location_zone_redundant" {
  description = "(Optional) Should zone redundancy be enabled for this region? Defaults to `false`."
  type        = bool
  default     = false
}

# This `geo_location` variable is replaced by the use of above `geo_location_*` variables.
# variable "geo_location" {
#   description = " Configures the geographic locations the data is replicated to and supports the following: location, failover_priority, and zone_redundant."
# }

# variable "ip_range_filter" {} # TODO: Implement this variable block.
# variable "enable_free_tier" {} # TODO: Implement this variable block.
# variable "analytical_storage_enabled" {} # TODO: Implement this variable block.

variable "enable_automatic_failover" {
  description = "(Optional) Enable automatic fail over for this Cosmos DB account."
  default     = false
  type        = bool
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this CosmosDB account."
  type        = bool
  default     = true
}


variable "enabled" {
  description = "(Optional) Enable the creation of this Cosmos DB account."
  default     = true
  type        = bool
}

variable "capabilities_allow_self_serve_upgrade_to_mongo_36" {
  description = "(Optional) Configures the AllowSelfServeUpgradeToMongo36 capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL."
  default     = false
  type        = bool
}

variable "capabilities_disable_rate_limiting_responses" {
  description = "(Optional) Configures the DisableRateLimitingResponses capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL."
  default     = false
  type        = bool
}

variable "capabilities_enable_aggregation_pipeline" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL."
  default     = false
  type        = bool
}

variable "capabilities_enable_cassandra" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_enable_gremlin" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_enable_mongo" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_enable_table" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_enable_serverless" {
  description = "(Optional) Configures the EnableServerless capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_mongo_db_v34" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

variable "capabilities_mongo_enable_doc_level_ttl" {
  description = "(Optional) Configures the EnableTable capability for this Cosmos DB account. Other capabilities are AllowSelfServeUpgradeToMongo36, DisableRateLimitingResponses, EnableAggregationPipeline, EnableCassandra, EnableGremlin, EnableMongo, EnableTable, EnableServerless, MongoDBv3.4 and mongoEnableDocLevelTTL. Note: Setting MongoDBv3.4 also requires setting EnableMongo."
  default     = false
  type        = bool
}

# This `capabilities` variable is replaced by the use of above `capabilities_*` variables.
# variable "capabilities" {
#   description = "(Optional) The capabilities which should be enabled for this Cosmos DB account. Value is a `capabilities` block as defined below. Changing this forces a new resource to be created."
# }

# variable "is_virtual_network_filter_enabled" {} # TODO: Implement this variable block.
# variable "key_vault_key_id" {} # TODO: Implement this variable block.
# variable "virtual_network_rule" {} # TODO: Implement this variable block.
# variable "enable_multiple_write_locations" {} # TODO: Implement this variable block.
# variable "access_key_metadata_writes_enabled" {} # TODO: Implement this variable block.
# variable "mongo_server_version" {} # TODO: Implement this variable block.
# variable "network_acl_bypass_for_azure_services" {} # TODO: Implement this variable block.
# variable "local_authentication_disabled" {} # TODO: Implement this variable block.

# variable "backup" {} # TODO: Implement this variable block.
# variable "cors_rule" {} # TODO: Implement this variable block.
# variable "identity" {} # TODO: Implement this variable block.
# variable "restore" {} # TODO: Implement this variable block.
