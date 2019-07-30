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

resource "azurerm_resource_group" "main" {
  name     = "${var.rgname}"
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

resource "azurerm_network_interface" "nic" {
  name                = "new-nic"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    private_ip_address_allocation = "Dynamic"
  }
  
  tags = {
    PROJECT = "${var.PROJ}"
    ENVIRONMENT = "${var.ENV}"
    OWNER = "${var.OWN}"
    APPLICATION = "${var.APP}"
    APPLICATION_CODE = "${var.APP_CODE}"    
    COSTCENTERID = "${var.CCID}"    
  }

}

resource "azurerm_virtual_machine" "main" {
  name                  = "testvm_build_tf"
  location              = "${azurerm_resource_group.main.location}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true


  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
    computer_name  = "hostname"
    admin_username = "${var.user}"
    admin_password = "${var.pass}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
  tags = {
    PROJECT = "${var.PROJ}"
    ENVIRONMENT = "${var.ENV}"
    OWNER = "${var.OWN}"
    APPLICATION = "${var.APP}"
    APPLICATION_CODE = "${var.APP_CODE}"    
    COSTCENTERID = "${var.CCID}"    
  }

}