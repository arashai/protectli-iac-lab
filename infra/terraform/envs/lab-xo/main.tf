terraform {
  required_version = ">= 1.6.0"

  required_providers {
    xenorchestra = {
      source  = "vatesfr/xenorchestra"
      version = "~> 0.31"
    }
  }
}

provider "xenorchestra" {
  url      = var.XOA_URL
  username = var.XOA_USER
  password = var.XOA_PASSWORD
  insecure = var.XOA_INSECURE == "true"
}

data "xenorchestra_pool" "localhost" {
  name_label = "localhost"
}

output "pool_names" {
  value = data.xenorchestra_pool.localhost.id
}
