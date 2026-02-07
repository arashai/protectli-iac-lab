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
  insecure = var.XOA_INSECURE
}

data "xenorchestra_pool" "lab" {
  name_label = var.pool_name
}

# --- Network discovery ---
data "xenorchestra_network" "lan" {
  name_label = var.network_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "network_id" {
  value = data.xenorchestra_network.lan.id
}

# --- Template discovery ---
data "xenorchestra_template" "base" {
  name_label = var.template_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "template_id" {
  value = data.xenorchestra_template.base.id
}

# --- Storage discovery ---
data "xenorchestra_sr" "main" {
  name_label = var.sr_name
  pool_id    = data.xenorchestra_pool.lab.id
}

output "sr_id" {
  value = data.xenorchestra_sr.main.id
}

resource "xenorchestra_vm" "test" {
  name_label  = var.vm_name
  template    = data.xenorchestra_template.base.id
  cpus        = 1
  memory_max  = 1073741824 # 1 GiB
  power_state = "Halted"

  network {
    network_id = data.xenorchestra_network.lan.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.main.id
    name_label = "root"
    size       = 10737418240 # 10 GiB
  }

  tags = ["terraform", "lab", "test"]
}

output "vm_id" {
  value = xenorchestra_vm.test.id
}
