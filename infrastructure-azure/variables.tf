variable "prefix" {
  description = "Prefix used in the resources names"
  default     = "enri-demo"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
}

variable "location" {
  description = "Location of the resource"
  type        = string
}
/*
 variable "public_ip_id" {
   description = "ID of the Public IP"
   type        = string
 }
 */