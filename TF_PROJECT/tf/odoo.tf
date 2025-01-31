resource "kubernetes_deployment" "odoo_app" {
  for_each = toset(var.envs)

  metadata {
    name      = "odoo-deployment"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
    labels = {
      app = "odoo"
    }
  }

  spec {
    replicas = var.replicas[each.key]

    selector {
      match_labels = {
        app = "odoo"
      }
    }

    template {
      metadata {
        labels = {
          app = "odoo"
        }
      }

      spec {	
		init_container {
			name    = "wait-for-postgres"
			image   = "alpine:3.17"
			command = [
				"/bin/sh",
				"-c",
				<<-EOF
				apk add --no-cache postgresql-client
				until pg_isready -h postgres-service -U odoo -d postgres; do
					echo "Waiting for PostgreSQL..."
					sleep 2
				done
				EOF
				]
		}

        container {  
          name  = "odoo"
          image = var.odoo_image
          port {
            container_port = 8069
        }
		resources {
			limits = {
			cpu    = "1000m"
			memory = "1024Mi"
			}
			requests = {
			cpu    = "500m"
			memory = "512Mi"
			}
		}
		

        # Update the DB_HOST to use the Kubernetes service name for PostgreSQL
		env {
		name  = "DB_HOST"
		value = "db"  # Must match the PostgreSQL service name
		}

		env {
		name  = "DB_USER"
		value = "odoo"  # Must match POSTGRES_USER in PostgreSQL
		}

		env {
		name  = "DB_PASSWORD"
		value = "odoo"  # Must match POSTGRES_PASSWORD in PostgreSQL
		}

		env {
		name  = "DB_NAME"
		value = "postgres"  # Must match POSTGRES_DB in PostgreSQL
		}

          liveness_probe {
            http_get {
              path = "/web"
              port = 8069
            }
            initial_delay_seconds = 120
			period_seconds = 10
            
          }

          readiness_probe {
            http_get {
              path = "/web"
              port = 8069
            }
            initial_delay_seconds = 180
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "odoo_svc" {
  for_each = toset(var.envs)

  metadata {
    name      = "odoo-service"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
  }
  spec {
    selector = {
      app = "odoo"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8069
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_job" "odoo_init_db" {
  for_each = toset(var.envs)  # Apply to all environments

  metadata {
    name      = "odoo-init-db-${each.key}"
    namespace = kubernetes_namespace.app_namespace[each.key].metadata[0].name
  }
  spec {
    template {
      metadata {
        labels = {
          app = "odoo-init-db"
        }
      }
      spec {
        container {
          name  = "odoo-init-db"
          image = var.odoo_image
          command = [
            "odoo",
            "--db_host=postgres-service",
            "--db_user=odoo",
            "--db_password=odoo",
            "--no-http",
            "--stop-after-init",
            "--init=base"
          ]
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4
  }

  depends_on = [
    kubernetes_deployment.postgresql,
    kubernetes_service.postgres
  ]
}

// Ingress for Production with HTTPS
resource "kubernetes_ingress_v1" "odoo_ingress" {
  for_each = { for env in var.envs : env => env if (env == "prod" && var.enable_https) }

  metadata {
    name        = "odoo-ingress"
    namespace   = kubernetes_namespace.app_namespace[each.value].metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    rule {
      host = "odoo-production-${lower(terraform.workspace)}.example.com"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.odoo_svc[each.value].metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = ["odoo-production-${lower(terraform.workspace)}.example.com"]
      secret_name = "odoo-tls"
    }
  }
}