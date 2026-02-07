variable "XOA_URL" {
  description = "Database administrator username"
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

variable "network_name" {
  type        = string
  description = "XO network name_label to attach VMs to (e.g. Pool-wide network associated with eth0)"
}

variable "pool_name" {
  type        = string
  description = "XO pool name_label to use (e.g. localhost)"
}
variable "template_name" {
  type        = string
  description = "XO template name_label to clone from (e.g., Ubuntu 24.04 Cloud-Init)"
}
variable "sr_name" {
  type        = string
  description = "Storage Repository name_label for VM disks"
}
variable "vm_name" {
  type        = string
  description = "Name of the VM to be created"
}
