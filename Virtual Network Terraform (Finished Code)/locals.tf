locals {
  resource_group_name   = "mkt-rsg"
  location              = "East US"
  networksecuritygrp    = "mkt-netsec"
  virtual_network ={
    name  = "mkt-virtualnetwork"
    address_space = "11.0.0.0/16"
  }
}

locals {
  resource_group_name   = "mkt-rsg_01"
  location              = "West US"
  networksecuritygrp    = "mkt-netsec_01"
  virtual_network ={
    name  = "mkt-virtualnetwork_01"
    address_space = "12.0.0.0/16"
  }
}
