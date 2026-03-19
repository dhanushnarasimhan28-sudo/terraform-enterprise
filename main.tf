module "rg" {
  source = "./Modules/resource_group"
  azurermresource_group_name = var.azurermresource_group_name
  location = var.location
}

module "network" {
  source = "./Modules/Network"
  vnetname = var.vnetname
  location = var.location
  azurermresource_group_name = var.azurermresource_group_name
  address_space = var.address_space

  depends_on = [ module.rg ]
}

module "vm" {
  source = "./Modules/VM"
  azurermresource_group_name = var.azurermresource_group_name
  location = var.location
  vmname = var.vmname
  keyvault_name = var.keyvault_name
  admin_username = var.admin_username
  admin_password = var.admin_password
  vm_size = var.vm_size
  websubnet_id = module.network.websubnet_id
  depends_on = [ module.network ]

}

module "keyvault" {
  source = "./Modules/Key_vault"
  azurermresource_group_name = var.azurermresource_group_name
  location = var.location
  keyvault_name = var.keyvault_name
  tenant_id = var.tenant_id
  object_id = var.object_id
  depends_on = [ module.rg ]
}

module "monitoring" {
  source = "./Modules/Monitoring"
  azurermresource_group_name = var.azurermresource_group_name
  vm_id = module.vm.vm_id
  depends_on = [ module.vm ]
}