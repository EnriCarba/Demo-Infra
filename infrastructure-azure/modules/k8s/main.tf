resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = "${var.prefix}-k8s"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "demok8s1"
  node_resource_group = "k8s-node-rg"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    zones               = [1, 2]
    enable_auto_scaling = true
    max_count           = 2
    min_count           = 1
    os_disk_size_gb     = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
