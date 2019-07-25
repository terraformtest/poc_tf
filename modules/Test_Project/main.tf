terraform {
  required_version = "> 0.8.0"
}

provider "azurerm" {
  subscription_id = "${var.subID}"
  client_id       = "${var.cliID}"
  client_secret   = "${var.cliSecret}"
  tenant_id       = "${var.tenID}"
  version = "~> 1.1"
}

resource "azurerm_resource_group" "group" {
  name     = "delete-me-rg-terraform"
  location = "${var.location}"
  tags = {
    PROJECT = "${var.PROJ}"
    ENVIRONMENT = "${var.ENV}"
    OWNER = "${var.OWN}"
    APPLICATION = "${var.APP}"
    APPLICATION_CODE = "${var.APP_CODE}"    
    COSTCENTERID = "${var.CCID}"    
  }
}