resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.azurermresource_group_name
  address_space       = [var.address_space]

  subnet {
    name             = "websubnet"
    address_prefixes = ["10.0.1.0/24"]
  }

}

resource "azurerm_network_security_group" "nsg" {
  name                = "terraform-nsg"
  location            = var.location
  resource_group_name = var.azurermresource_group_name


  security_rule {
  name                        = "allow-rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_port_range      = "3389"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  }

  security_rule {
  name                        = "allow-http"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  source_port_range           = "*"
}
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = one(azurerm_virtual_network.vnet.subnet).id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
