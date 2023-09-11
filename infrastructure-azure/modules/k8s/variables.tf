variable "prefix" {
  description = "Prefix used in the resources names"
  default     = "enri-demo"
  type        = string
}

variable "location" {
  description = "Azure Kubernetes Location"
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}
