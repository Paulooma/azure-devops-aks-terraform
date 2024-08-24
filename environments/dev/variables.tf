variable "administrator" {
  type = string
}
variable "application" {
  type = string

}
variable "country" {
  type = string
}

variable "deployment" {
  type = string

}

variable "description" {
  type = string
}

variable "region" {
  description = "Azure region to deploy to"
}

variable "node_count" {
  description = "The node count for the default node pool"
  default     = 1
}

variable "vm_size" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}

variable "sdlc_environment" {
  description = "The value for the sdlc environment"
  default     = "dev"
}

locals {
  authorized_ip_ranges = ["${chomp(data.http.myip.response_body)}/32"]
  aks_tags = {
    Administrator = "${var.administrator}"
    Application   = "${var.application}"
    Country       = "${var.country}"
    Deployment    = "${var.deployment}"
    Stage         = "${var.sdlc_environment}"
    Description   = "${var.description}"
    DeployedOn    = timestamp()
  }
}