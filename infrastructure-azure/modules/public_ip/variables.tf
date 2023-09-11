variable "prefix" {
  description = "Prefix used in the resources names"
  default     = "enri-demo"
  type        = string
}

variable "location" {
  description = "Location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
}