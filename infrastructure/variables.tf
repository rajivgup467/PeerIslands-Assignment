variable "resource_group_name" { default = "rg-aks-prod" }
variable "location" { default = "eastus" }
variable "cluster_name" { default = "aks-prod-cluster" }
variable "acr_name" { default = "acrprodappdemo" }
variable "vnet_name" { default = "vnet-prod" }
variable "subnet_name" { default = "subnet-aks" }
variable "node_count" { default = 2 }
variable "node_vm_size" { default = "Standard_DS2_v2" }
