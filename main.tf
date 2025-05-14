# Configure the AzureRM provider
# This block defines the cloud provider Terraform will interact with.
# Ensure you have the necessary provider version that supports Azure Stack HCI LCM resources (check the provider documentation).
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0" # Use an appropriate version supporting Azure Stack HCI LCM resources
    }
  }
}

# Configure the AzureRM provider to authenticate with Azure
# This block uses the variables defined above to authenticate the provider.
# Using client_credentials is typical for Service Principal authentication.
# If you are using a different authentication method (e.g., user/password via Azure CLI),
# you might need to adjust the provider block parameters accordingly.
# Refer to the AzureRM provider documentation for details on supported authentication methods.
provider "azurerm" {
  features {} # Enables the features block for provider configuration
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  # For user/password authentication, you might need different parameters or use the Azure CLI provider
  # Check AzureRM provider documentation for details on authentication methods
}

# Create the Virtual Machine resource on Azure Stack HCI
# This resource block defines the desired state of the Virtual Machine.
resource "azurerm_lcm_virtual_machine" "hci_vm" {
  # The name of the Azure Stack HCI cluster resource in Azure that this VM will be deployed to.
  azure_stack_hci_cluster_name = var.cluster_name
  # The Azure region where the Azure Stack HCI cluster resource is located.
  location                     = var.location
  # The name of the resource group in Azure where the Azure Stack HCI cluster resource resides.
  resource_group_name          = var.resource_group_name
  # The desired name for the new Virtual Machine.
  name                         = var.vm_name

  # Hardware profile configuration for the VM
  hardware_profile {
    # The size of the Virtual Machine, determining its compute resources.
    vm_size = var.vm_size
  }

  # Operating System profile configuration for the VM
  os_profile {
    # The administrator username for the guest operating system.
    admin_username = var.admin_username
    # The administrator password for the guest operating system. Marked as sensitive.
    admin_password = var.admin_password
    # The computer name for the guest operating system. Often set to the VM name.
    computer_name  = var.vm_name
  }

  # Storage profile configuration for the VM's disks
  storage_profile {
    # Define the operating system disk for the VM
    os_disk {
      # The name of the OS disk.
      name              = "${var.vm_name}-osdisk"
      # The absolute path on the Azure Stack HCI volume storage where the new OS disk VHD/VHDX file will be created.
      vhd_path          = "${var.storage_path}\\${var.vm_name}-osdisk.vhdx" # Example path structure, adjust as needed
      # The absolute path to the source operating system image VHD/VHDX file on your volume storage.
      source_image_path = var.os_image_path
    }

    # You can add additional data disks here if needed for application data, etc.
    # data_disk {
    #   # The name of the data disk.
    #   name     = "${var.vm_name}-datadisk1"
    #   # The absolute path on the Azure Stack HCI volume storage where the new data disk VHD/VHDX file will be created.
    #   vhd_path = "${var.storage_path}\\${var.vm_name}-datadisk1.vhdx"
    #   # The size of the data disk in GB.
    #   disk_size_gb = 100 # Example size, update as needed
    # }
  }

  # Network profile configuration for the VM's network interfaces
  network_profile {
    # Define the network interfaces for the VM
    network_interfaces {
      # The Azure Resource ID of the Logical Network or Network Interface Card resource to attach.
      id = var.network_resource_id
      # Set primary to true for the main network interface.
      primary = true
    }
    # You can add more network interfaces here if the VM requires multiple network connections.
  }

  # Tags (optional but highly recommended for organization and cost management)
  tags = {
    REF = "CPR######" # Example tag, replace with your actual reference
    Created_by  = "user-email"   # Example tag, replace with the user's email or identifier
  }
}
