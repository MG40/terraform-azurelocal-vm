# terraform-azurelocal-vm
IaC to provision virtual machines on Azure Local using Terraform. 

# Azure Stack HCI VM Automation with Terraform

This repository contains Terraform scripts to automate the creation of Virtual Machines on Azure Stack HCI clusters.

## Project Description

This project provides a simple and repeatable way to provision Virtual Machines on an Azure Stack HCI environment using HashiCorp Terraform. By defining the desired VM configuration in code, you can ensure consistency and reduce manual effort.

## Prerequisites

Before using these scripts, ensure you have the following:

1. **Terraform Installed:** Download and install Terraform from the official website (<https://www.terraform.io/downloads>).

2. **AzureRM Provider:** The scripts use the AzureRM provider. Terraform will automatically download the required version during initialization (`terraform init`).

3. **Azure Stack HCI Cluster:** An operational Azure Stack HCI cluster.

4. **Azure Arc Integration:** Your Azure Stack HCI cluster should be registered with Azure Arc.

5. **Permissions:** Appropriate permissions in your Azure subscription and on the Azure Stack HCI cluster to create resources.

6. **OS Image:** A VHD or VHDX file containing the operating system you want to deploy, accessible on your Azure Stack HCI volume storage.

7. **Network Configuration:** Details of your Azure Stack HCI logical network or network interface card resource (specifically its Azure Resource ID).

8. **Authentication Method:** Credentials to authenticate with Azure (e.g., Service Principal details - Client ID, Client Secret, Tenant ID, Subscription ID).

## Usage

1. **Clone the Repository:**

   Clone the repository to your local machine. Replace `<your-repository-url>` with the actual URL of your GitHub repository and `<repo-name>` with the desired local directory name.

   ```bash
   git clone <your-repository-url> <repo-name>
   cd <repo-name>```

2. **Initialize Terraform:** Navigate to the directory containing the Terraform files (`.tf`) and initialize Terraform. This downloads the necessary provider plugins.

    `terraform init`

3. **Configure Variables:** Create a `terraform.tfvars` file (or use environment variables) to provide values for the variables defined in the `variables.tf` (or directly in the main `.tf` file). **Be extremely cautious with sensitive variables like `client_secret` and `admin_password`. Consider using a secrets management solution.**

Example `terraform.tfvars`:

```hcl
subscription_id     = "your-azure-subscription-id"
tenant_id           = "your-azure-tenant-id"
client_id           = "your-service-principal-client-id"
client_secret       = "your-service-principal-client-secret"
resource_group_name = "your-resource-group-name"
cluster_name        = "your-azure-stack-hci-cluster-name" # e.g., mcl-ax750-cls01.edub.csc
location            = "your-azure-region"
vm_name             = "my-new-vm"
vm_size             = "Standard_A2_v2" # Or another appropriate size
os_image_path       = "C:\\ClusterStorage\\Volume1\\Images\\my-os-image.vhdx" # Update with your actual path
admin_username      = "localadmin"
admin_password      = "your-secure-password"
network_resource_id = "/subscriptions/your-subscription-id/resourceGroups/your-resource-group/providers/Microsoft.AzureStackHCI/logicalNetworks/your-logical-network-name" # Update with your actual Resource ID
storage_path        = "C:\\ClusterStorage\\Volume1\\VMs" # Update with your desired storage path
```

Plan the Deployment: Run terraform plan to see the execution plan. This shows you what Terraform will do without actually making any changes.

```terraform plan```

Apply the Deployment: If the plan looks correct, apply the changes to create the VM.

```terraform apply```

You will be prompted to confirm the action. Type `yes` to proceed.

## Important Notes

**Security:** Never commit sensitive information (like passwords or secrets) directly into your GitHub repository. Use `.gitignore` for `terraform.tfvars` and consider using a secrets management solution for production deployments.

**Azure Stack HCI Provider:** Ensure the AzureRM provider version you are using supports the Azure Stack HCI LCM (Life Cycle Management) resources. Refer to the AzureRM provider documentation for compatibility.

**Paths:** The os_image_path and storage_path should be the paths accessible from the Azure Stack HCI.
