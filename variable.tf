# Define variables for sensitive and configuration details
# Variables allow you to parameterize your Terraform code, making it reusable.
# It's highly recommended to use a secrets management solution (like Azure Key Vault)
# for production environments instead of storing sensitive data directly in variable files.
variable "subscription_id" {
  description = "The Azure Subscription ID where the Azure Stack HCI cluster is registered."
  type        = string
  sensitive   = true # Marks the variable as sensitive, preventing its value from being shown in plan/apply outputs
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
  sensitive   = true # Marks the variable as sensitive
}

variable "client_id" {
  description = "The Client ID for the Service Principal or user used for authentication."
  type        = string
  sensitive   = true # Marks the variable as sensitive
}

variable "client_secret" {
  description = "The Client Secret for the Service Principal or password for the user used for authentication."
  type        = string
  sensitive   = true # Marks the variable as sensitive
}

variable "resource_group_name" {
  description = "The name of the resource group in Azure where the Azure Stack HCI cluster resource resides."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Azure Stack HCI cluster resource in Azure."
  type        = string
  # Removed the default value to require explicit input when running terraform
}

variable "location" {
  description = "The Azure region where the Azure Stack HCI cluster resource is located. This should match the location of the cluster resource in Azure."
  type        = string
  default     = "East US" # Example location, update this to your actual Azure region
}

variable "vm_name" {
  description = "The desired name for the new Virtual Machine to be created on Azure Stack HCI."
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine, defining its vCPU and RAM. Examples: 'Standard_A2_v2', 'Standard_D2s_v3'."
  type        = string
}

variable "os_image_path" {
  description = "The absolute path to the operating system VHD or VHDX file located on your Azure Stack HCI volume storage. This is the source image for the OS disk."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the operating system of the new VM."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the operating system of the new VM."
  type        = string
  sensitive   = true # Marks the variable as sensitive
}

variable "network_resource_id" {
  description = "The Azure Resource ID of the Logical Network or Network Interface Card resource that the VM will connect to on Azure Stack HCI."
  type        = string
}

variable "storage_path" {
  description = "The base path on the Azure Stack HCI volume storage where the VM configuration files and virtual hard disks will be stored."
  type        = string
}
