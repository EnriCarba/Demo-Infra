resource "azurerm_public_ip" "pub_ip" {
  name                = "${var.prefix}-PublicIPforLoadBal"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Development"
  }
}