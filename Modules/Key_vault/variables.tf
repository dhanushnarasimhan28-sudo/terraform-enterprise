variable "azurermresource_group_name" {}
variable "location" {  }
variable "keyvault_name" {}
variable "tenant_id" {}

variable "object_id" {
  description = "Object ID of user/service principal"
  type        = string
}