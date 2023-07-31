module "vmtest"{
    is_linux = true
 source = "./mm"
 name = "neha"
 admin_password = "redtesr346"
 os_disk = {
        caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
    name          =         "test-neha"
 }
 location = "east us"
 subnet_id =data.azurerm_subnet.subnet_id.id
 resource_group_name = "rggroup"
 size = "StandardB2s"
 source_image_reference = {
     publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
 }
 new_network_interface = {
    name = "neha-test"
    ip_configurations = {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_id.id
    private_ip_address_allocation = "Dynamic"

 }
}
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC85sAFPeACq8bErGObf3YQ7e7AIR3y0qVuuVyNacZfm+588e17fI2EbV4ctM1/mAOw2XxYgY1LikV+XeeBO0anjr9GJqIuCo8atv3OvDZITSkBg1hXeXmFJCFZt1iQ7bTJ/K1eb2S9+uiAknYCt/hz+sr6P+i4eo4lta6FnoT0aqWdtvOpXQ7c+ogimxwklCnc8WIMtWhPug6KuCGLB6fXD+7z0jdKfXkFcthQRBSz8+8ii4G/sdlDVTnjRUnf15elE1mDrtdYTjvTEmWQkYg6RlgM/R7ZSe450C7bX3WpLz9VNK6Z/UrkIYdTPmmDG5zlc+ibHZJ7s0hqkZ+6wwTH rsa-key-20230731"
}

data "azurerm_subnet" "subnet_id" {
  name                 = "default"
  virtual_network_name = "vnet"
  resource_group_name  = "rggroup"
}