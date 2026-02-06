variable "XOA_URL" {
  description = "Database administrator username"
  type        = string
  sensitive   = false
}

variable "XOA_USER" {
  description = "Service Account Username for XOA"
  type        = string
  sensitive   = true
}

variable "XOA_PASSWORD" {
  description = "Service Account Password for XOA"
  type        = string
  sensitive   = true
}

variable "XOA_INSECURE" {
  description = "Whether to skip SSL verification"
  type        = string
  sensitive   = true
}
