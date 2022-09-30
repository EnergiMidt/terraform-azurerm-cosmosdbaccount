locals {
  standard_name = var.name
  # standard_name = "${var.name}${var.environment}"

  cosmosdb_account = concat(azurerm_cosmosdb_account.account.*, [null])[0]

  # tflint-ignore: terraform_unused_declarations
  validate_capabilities_mongo_db_v34 = (var.capabilities_mongo_db_v34 == true && var.capabilities_enable_mongo == false) ? tobool("Setting `MongoDBv3.4` also requires setting `EnableMongo`.") : true
}

resource "azurerm_cosmosdb_account" "account" {
  count = var.enabled ? 1 : 0

  name                = var.override_name != "" ? var.override_name : local.standard_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  offer_type = var.offer_type

  dynamic "analytical_storage" {
    for_each = var.analytical_storage_schema_type == null ? [] : [1]
    content {
      schema_type = var.analytical_storage_schema_type
    }
  }

  kind = var.kind

  enable_automatic_failover     = var.enable_automatic_failover
  public_network_access_enabled = var.public_network_access_enabled

  consistency_policy {
    consistency_level       = var.consistency_policy_consistency_level
    max_interval_in_seconds = var.consistency_policy_max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }

  geo_location {
    location          = var.geo_location_location
    failover_priority = var.geo_location_failover_priority
    zone_redundant    = var.geo_location_zone_redundant
  }

  dynamic "capabilities" {
    for_each = var.capabilities_allow_self_serve_upgrade_to_mongo_36 == false ? [] : [1]
    content {
      name = "AllowSelfServeUpgradeToMongo36"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_disable_rate_limiting_responses == false ? [] : [1]
    content {
      name = "DisableRateLimitingResponses"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_aggregation_pipeline == false ? [] : [1]
    content {
      name = "EnableAggregationPipeline"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_cassandra == false ? [] : [1]
    content {
      name = "EnableCassandra"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_gremlin == false ? [] : [1]
    content {
      name = "EnableGremlin"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_mongo == false ? [] : [1]
    content {
      name = "EnableMongo"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_table == false ? [] : [1]
    content {
      name = "EnableTable"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_enable_serverless == false ? [] : [1]
    content {
      name = "EnableServerless"
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_mongo_db_v34 == false ? [] : [1]
    content {
      # name = ["EnableMongo", "MongoDBv3.4"] # Setting `MongoDBv3.4` also requires setting `EnableMongo`.
      name = "MongoDBv3.4" # Setting `MongoDBv3.4` also requires setting `EnableMongo`.
    }
  }

  dynamic "capabilities" {
    for_each = var.capabilities_mongo_enable_doc_level_ttl == false ? [] : [1]
    content {
      name = "mongoEnableDocLevelTTL"
    }
  }

  timeouts {
    create = "180m"
    update = "180m"
    read   = "5m"
    delete = "180m"
  }
}
