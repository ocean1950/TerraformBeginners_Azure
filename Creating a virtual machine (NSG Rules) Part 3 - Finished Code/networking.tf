resource "azurerm_network_security_group" "mkt-netsec" {
  name                = local.networksecuritygrp
  location            = local.location
  resource_group_name = local.resource_group_name

 security_rule {
    name                       = "RDP"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389" 
    source_address_prefixes    = ["81.168.172.211", "200.160.201.60"]
    destination_address_prefix = "*"
  }



  depends_on = [ 
    azurerm_resource_group.mkt-rsg 
    ]

}



resource "azurerm_virtual_network" "mkt-virtualnetwork" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtual_network.address_space]
  

  depends_on = [ 
    azurerm_resource_group.mkt-rsg
    ]

}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.mkt-virtualnetwork.name
  address_prefixes     = ["11.0.1.0/24"]

}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.mkt-virtualnetwork.name
  address_prefixes     = ["11.0.2.0/24"]

}

resource "azurerm_network_interface" "mkt-netinterface" {
  name                = "mkt-netinterface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mkt-pubip.id
  }

  depends_on = [ 
    azurerm_resource_group.mkt-rsg 
    ]
}

resource "azurerm_network_interface_security_group_association" "mkt-netinterface_associate" {
  network_interface_id      = azurerm_network_interface.mkt-netinterface.id
  network_security_group_id = azurerm_network_security_group.mkt-netsec.id
}

resource "azurerm_public_ip" "mkt-pubip" {
  name                = "mkt-pubip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"

}

resource "azurerm_subnet_network_security_group_association" "subnet1associate" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.mkt-netsec.id
}

resource "azurerm_subnet_network_security_group_association" "subnet2associate" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.mkt-netsec.id
}



/*

    security_rule {
    name                       = "RDP"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "71.168.176.211"
    destination_address_prefix = "*"
  }

  */