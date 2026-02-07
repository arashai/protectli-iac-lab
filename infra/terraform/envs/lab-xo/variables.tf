variable "XOA_URL" {
  description = "Xen Orchestra URL"
  type        = string
  sensitive   = false
}

variable "XOA_USER" {
  description = "Service Account Username for XOA"
  type        = string
  sensitive   = false
}

variable "XOA_PASSWORD" {
  description = "Service Account Password for XOA"
  type        = string
  sensitive   = true
}

variable "XOA_INSECURE" {
  description = "Whether to skip SSL verification"
  type        = string
  sensitive   = false
}

variable "mgmt_network_name" {
  type        = string
  description = "XO network name_label for managment network (e.g. Pool-wide network associated with eth0)"
}

variable "lan_network_name" {
  type        = string
  description = "XO network name_label for LAN network (e.g. Pool-wide network associated with eth2)"
}

variable "wan_network_name" {
  type        = string
  description = "XO network name_label for WAN network (e.g. Pool-wide network associated with eth3)"
}

variable "pool_name" {
  type        = string
  description = "XO pool name_label to use (e.g. localhost)"
}
variable "sr_name" {
  type        = string
  description = "Storage Repository name_label for VM disks"
}
variable "firewall_vm_name" {
  type        = string
  description = "Name of the firewall VM to be created"
}
variable "firewall_template_name" {
  type        = string
  description = "XO template name_label to clone from (e.g., pfSense 2.6)"
}
