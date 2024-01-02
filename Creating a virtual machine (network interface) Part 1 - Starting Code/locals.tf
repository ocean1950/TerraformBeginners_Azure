locals {
  resource_group_name   = "mkt-rsg"
  location              = "East US"
  networksecuritygrp    = "mkt-netsec"
  virtual_network ={
    name  = "mkt-virtualnetwork"
    address_space = "11.0.0.0/16"
  }
}