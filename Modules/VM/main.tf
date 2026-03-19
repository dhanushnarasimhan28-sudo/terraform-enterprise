resource "azurerm_network_interface" "nic" {
  name                = "dhanush-nic"
  location            = var.location
  resource_group_name = var.azurermresource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmname
  resource_group_name = var.azurermresource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "publicip" {
  name                = "public-ip"
  resource_group_name = var.azurermresource_group_name
  location            = var.location
  allocation_method   = "Static"
}