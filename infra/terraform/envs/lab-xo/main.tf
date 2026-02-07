terraform {
  required_version = ">= 1.6.0"

  required_providers {
    xenorchestra = {
      source  = "vatesfr/xenorchestra"
      version = "~> 0.37"
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
data "xenorchestra_network" "mgmt" {
  name_label = var.mgmt_network_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "network_id" {
  value = data.xenorchestra_network.mgmt.id
}
data "xenorchestra_network" "lan" {
  name_label = var.lan_network_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "lan_network_id" {
  value = data.xenorchestra_network.lan.id
}
data "xenorchestra_network" "wan" {
  name_label = var.wan_network_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "wan_network_id" {
  value = data.xenorchestra_network.wan.id
}
# --- Template discovery ---
data "xenorchestra_template" "firewall" {
  name_label = var.firewall_template_name
  pool_id    = data.xenorchestra_pool.lab.id
}
output "template_id" {
  value = data.xenorchestra_template.firewall.id
}

# --- Storage discovery ---
data "xenorchestra_sr" "main" {
  name_label = var.sr_name
  pool_id    = data.xenorchestra_pool.lab.id
}

output "sr_id" {
  value = data.xenorchestra_sr.main.id
}

# --- Firewall creation ---
resource "xenorchestra_vm" "firewall" {
  name_label  = var.firewall_vm_name
  template    = data.xenorchestra_template.firewall.id
  cpus        = 2
  memory_max  = 4000000000 # 4 GiB
  power_state = "Halted"
  network {
    network_id = data.xenorchestra_network.lan.id
  }
  network {
    network_id = data.xenorchestra_network.wan.id
  }
  network {
    network_id = data.xenorchestra_network.mgmt.id
  }
  disk {
    sr_id      = data.xenorchestra_sr.main.id
    name_label = "root"
    size       = 64000000000 # 64 GiB
  }

  tags = ["terraform", "firewall", "pfSense"]
}

output "vm_id" {
  value = xenorchestra_vm.firewall.id
}
