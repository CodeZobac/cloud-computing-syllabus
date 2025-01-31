output "namespaces_created" {
  description = "List of namespaces for each environment"
  value       = [for env in var.envs : kubernetes_namespace.app_namespace[env].metadata[0].name]
}

output "odoo_services" {
  description = "Details of created Odoo services"
  value       = { for env, svc in kubernetes_service.odoo_svc : env => svc.metadata[0] }
}