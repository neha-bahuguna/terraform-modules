resource "azurerm_linux_virtual_machine" "vm_linux" {
  count = var.is_linux ? 1 : 0

  admin_username                  = var.admin_username
  location                        = var.location
  name                            = var.name
  network_interface_ids           = var.new_network_interface == null ? var.network_interface_ids :  [azurerm_network_interface.vm[0].id] 
  resource_group_name             = var.resource_group_name
  size                            = var.size
  admin_password                  = var.admin_password
  computer_name                   = var.computer_name
  custom_data                     = var.custom_data
  encryption_at_host_enabled      = var.encryption_at_host_enabled
  eviction_policy                 = var.eviction_policy
  availability_set_id             = var.availability_set_id
  source_image_id                 = var.source_image_id
  tags                            = var.tags
  user_data                       = var.user_data
  virtual_machine_scale_set_id    = var.virtual_machine_scale_set_id
  zone                            = var.zone

  os_disk {
    caching                = var.os_disk.caching
    storage_account_type   = var.os_disk.storage_account_type
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
    disk_size_gb           = var.os_disk.disk_size_gb
    name                   = var.os_disk.name
  }

  admin_ssh_key {
    public_key = var.public_key
    username   = var.admin_username
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  source_image_reference {
    offer     = var.source_image_reference.offer
    publisher = var.source_image_reference.publisher
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
  lifecycle {

    ignore_changes = [tags]
  }
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  count = var.is_windows ? 1 : 0
  admin_password               = var.admin_password
  admin_username               = var.admin_username
  location                     = var.location
  name                         = var.name
  network_interface_ids           = var.new_network_interface == null ? var.network_interface_ids :  [azurerm_network_interface.vm[0].id] 
  resource_group_name          = var.resource_group_name
  size                         = var.size
  eviction_policy              = var.eviction_policy
  custom_data                  = var.custom_data
  availability_set_id          = var.availability_set_id
  source_image_id              = var.source_image_id
  tags                         = var.tags
  user_data                    = var.user_data
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  zone                         = var.zone

  os_disk {
    caching                = var.os_disk.caching
    storage_account_type   = var.os_disk.storage_account_type
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
    disk_size_gb           = var.os_disk.disk_size_gb
    name                   = var.os_disk.name


  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  source_image_reference {
    offer     = var.source_image_reference.offer
    publisher = var.source_image_reference.publisher
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  lifecycle {

    ignore_changes = [tags]
  }
}

resource "azurerm_network_interface" "vm" {
  count               = var.new_network_interface == null ? 0 : 1
  location            = var.location
  name                = var.new_network_interface.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                                               = var.new_network_interface.ip_configurations.name
    private_ip_address_allocation                      = var.new_network_interface.ip_configurations.private_ip_address_allocation
    gateway_load_balancer_frontend_ip_configuration_id = var.new_network_interface.ip_configurations.gateway_load_balancer_frontend_ip_configuration_id
    primary                                            = var.new_network_interface.ip_configurations.primary
    private_ip_address                                 = var.new_network_interface.ip_configurations.private_ip_address
    private_ip_address_version                         = var.new_network_interface.ip_configurations.private_ip_address_version
    public_ip_address_id                               = var.new_network_interface.ip_configurations.public_ip_address_id
    subnet_id                                          = var.subnet_id
  }

  lifecycle {

    ignore_changes = [tags]
  }
}