resource "azurerm_resource_group" "rg" {
  name     = var.azurermresource_group_name
  location = var.location
}