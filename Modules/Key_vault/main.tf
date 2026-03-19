data "azurerm_client_config" "current" {}

locals {
  resolved_object_id = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.object_id)) ? var.object_id : data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.azurermresource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = local.resolved_object_id

  secret_permissions = ["Get", "List", "Set"]
}