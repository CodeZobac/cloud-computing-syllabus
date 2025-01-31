resource "kubernetes_secret" "db_credentials" {
  for_each = toset(var.envs)

  metadata {
    name      = "db-credentials"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
  }

  # Use string_data for plaintext values (automatically encoded to base64)
  data = {
    POSTGRES_USER     = "odoo"
    POSTGRES_PASSWORD = "odoo"
    POSTGRES_DB       = "postgres"
  }
}

resource "kubernetes_deployment" "postgresql" {
  for_each = toset(var.envs)

  metadata {
    name      = "postgresql"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
    labels = {
      app = "postgresql"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgresql"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgresql"
        }
      }

      spec {
        container {
          name  = "postgresql"
          image = "postgres:16"
          
          # Update the PostgreSQL deployment environment variables to match Odoo's expectations
          env {
            name  = "POSTGRES_USER"
            value = "odoo"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "odoo"  # Ensure this matches Odoo's DB_PASSWORD
          }

          env {
            name  = "POSTGRES_DB"
            value = "postgres"  # Ensure this matches Odoo's DB_NAME
          }

          port {
            container_port = 5432
          }

          readiness_probe {
            exec {
              command = ["pg_isready", "-U", "odoo", "-d", "postgres"]
            }
            initial_delay_seconds = 30
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  for_each = toset(var.envs)
  metadata {
    name      = "db"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
  }
  spec {
    selector = {
      app = "postgresql"
    }
    port {
      port        = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}


