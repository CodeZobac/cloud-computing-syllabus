terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "minikube" {
  # Configuration options
}

provider "kubernetes" {
  # Configuration options
  host = minikube_cluster.cluster.host
  client_certificate = minikube_cluster.cluster.client_certificate
  client_key = minikube_cluster.cluster.client_key
  cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
}

variable "namespaces" {
  type = list(string)
  description = "Kubernetes Namespaces"
  nullable = false
}

variable "app" {
  description = "App Definition"
  type = object({
    name = string
    replicas = map(number)
    image = string
    containerName = string
    port= number
  })
  nullable = false
}

resource "minikube_cluster" "cluster" {
    cluster_name = "ex2"
    nodes = 1
}

resource "kubernetes_namespace" "environment" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.key
  }
}


resource "kubernetes_deployment" "app" {
    for_each = toset(var.namespaces)
    metadata {
        name = "${var.app.name}-${each.key}"
        namespace = each.key
        labels = {
            app = "${var.app.name}-${each.key}"
        }
    }
    spec {
        replicas = var.app.replicas[each.key]
        selector {
            match_labels = {
                app = "${var.app.name}-${each.key}"
            }
        }
        template {
            metadata {
                labels = {
                    app = "${var.app.name}-${each.key}"
                }
            }

            spec {
                container {
                    image = var.app.image
                    name  = var.app.containerName
                    port {
                      container_port = var.app.port
                    }
                }
            }
        }
    }
}