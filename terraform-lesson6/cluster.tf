resource "kubernetes_namespace" "example" {
  metadata {
    name = "1st-namespace"
  }
}