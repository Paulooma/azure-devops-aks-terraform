resource "random_integer" "vnet_cidr" {
  min = 10
  max = 250
}

resource "random_integer" "services_cidr" {
  min = 64
  max = 99
}

resource "random_integer" "pod_cidr" {
  min = 100
  max = 127
}

resource "random_id" "this" {
  byte_length = 2
}

resource "random_pet" "this" {
  length    = 1
  separator = ""
}

locals {
  location             = var.region
  aks_name             = lower("rg-${var.country}-${var.application}-${var.sdlc_environment}")
  aks_node_rg_name     = lower("rg-nodes-${var.country}-${var.application}-${var.sdlc_environment}")
  vnet_cidr            = cidrsubnet("10.0.0.0/8", 8, random_integer.vnet_cidr.result)
  pe_subnet_cidir      = cidrsubnet(local.vnet_cidr, 8, 1)
  api_subnet_cidir     = cidrsubnet(local.vnet_cidr, 8, 2)
  nodes_subnet_cidir   = cidrsubnet(local.vnet_cidr, 8, 3)
  compute_subnet_cidir = cidrsubnet(local.vnet_cidr, 8, 10)
  authorized_ip_ranges = [ "${chomp(data.http.myip.response_body)}/32" ]
  resource_name        = "${random_pet.this.id}-${random_id.this.dec}"
  aks_tags = {
    Administrator = "${var.administrator}"
    Application   = "${var.application}"
    Country       = "${var.country}"
    Deployment    = "${var.deployment}"
    Stage         = "${var.sdlc_environment}"
    Description   = "${var.description}"
    DeployedOn  = timestamp()
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.aks_name
  location = local.location

  tags = var.tags
}