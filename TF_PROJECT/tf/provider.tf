terraform {
  required_version = ">= 1.0.0"
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
  backend "local" {}
}

// Kubernetes Provider - uses local kubeconfig
provider "kubernetes" {
  config_path = "~/.kube/config"
}