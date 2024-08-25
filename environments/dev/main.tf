data "http" "myip" {
  url = "http://checkip.amazonaws.com/"
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "aks" {
  source               = "../../aks/module"
  administrator        = var.administrator
  application          = var.application
  country              = var.country
  description          = var.description
  deployment           = var.deployment
  region               = var.region
  authorized_ip_ranges = local.authorized_ip_ranges
  public_key_openssh   = tls_private_key.rsa.public_key_openssh
  tags                 = local.aks_tags
  kubernetes_version   = "1.29"
  sdlc_environment     = "dev"
  vm_sku               = var.vm_size
  vm_os                = "Ubuntu"
  node_count           = var.node_count
  enable_mesh          = false
  zones                = ["2"]
}