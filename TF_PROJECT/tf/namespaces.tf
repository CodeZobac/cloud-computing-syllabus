resource "kubernetes_namespace" "app_namespace" {
  for_each = toset(var.envs)

  metadata {
    name = "${lower(terraform.workspace)}-${each.value}"
  }
}