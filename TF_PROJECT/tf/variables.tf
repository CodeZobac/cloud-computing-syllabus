variable "clients" {
  type        = list(string)
  description = "List of client names (e.g., [\"Netflix\", \"Meta\", \"Rockstar\"])."
  default     = ["Netflix", "Meta", "Rockstar"]
}

variable "envs" {
  type        = list(string)
  description = "List of dynamic environments for the current workspace (e.g., [\"dev\", \"qa\", \"prod\", \"staging\"])."
}

variable "replicas" {
  type        = map(number)
  description = "Replica count per environment for the current workspace."
}

variable "odoo_image" {
  type        = string
  description = "Odoo Docker image to deploy."
  default     = "odoo:16.0"
}

variable "enable_https" {
  type        = bool
  description = "Enable HTTPS configuration for production."
  default     = true
}