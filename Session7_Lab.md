# Session 7: Automating Kubernetes with Terraform

## Objectives
- Automate cluster creation and management with Terraform.
- Use Terraform to create a dynamic number of namespaces and deployments using loops and variables 

---

## Lab Outline

### Step 1: Automating Minikube/Kind Cluster Creation

1. **Install Required Tools**:
   - Ensure Terraform is installed (refer to Session 6 if needed).
   - Ensure Minikube is installed:
     ```bash
     # Start a existing Minikube cluster:
     minikube start
     terraform init
     ```
---

### Step 2: Automating Namespace Creation with Terraform

> [!IMPORTANT]
> In this lab we will consider each kubernetes namespace as an 'environment'. You can adapt this concept to fit your/client's needs

1. **Define the variables**
```terraform
variable "environments" {
  type = list(string)
  description = "Kubernetes namespace (environment)"
  nullable = false
}


variable "app" {
  description = "Deployment definition"
  type = object({
    name = string
    replicas = number
    image = number
    port = number
  })
  nullable = false
}

```
1. **Define the variables you need to use to create namespaces and deployments**:
  - Open `namespace.tf` to see the Terraform configuration for creating namespaces:
  ```hcl
  resource "kubernetes_namespace" "environment" {
    for_each = toset(var.environments)
    metadata {
      name = each.key
    }
  }
  ```
  - Open `deployment.tf` and configure your application:
  ```hcl
  resource "kubernetes_deployment" "app" {
    for_each = toset(var.environments)
    metadata {
      name = "${var.app.name}-${each.key}"
      namespace = each.key
    }
  }

  resource "kubernetes_deployment" "app" {
    for_each = toset(var.environments)
    metadata {
      name = "${var.app.name}-${each.key}"
      namespace = each.key
    }
    spec {
      replicas = var.app.replicas
      selector {
          match_labels = {
            app = "${var.app.name}-${each.key}"

          }
      }
      template {
      
        metadata {
          labels =  {
            app = "${var.app.name}-${each.key}"
          }       
        }
        spec {
          container {
            image = var.app.image
            port {
              container_port = var.app.port
            }
          }
        }
      }
    }
  }
  ```

  - configure `session7.tfvars` and fill the variables:
    ```hcl
    environments = ["dev","prod"]
    app = {

      name = "my-app"
      port = 80
      image = "nginx:alpine"
      replicas = 3
    }
    ```

2. **Apply the Configuration**:
   ```bash
   terraform init
   terraform plan -var-file=session7.tfvars -out plan
   terraform apply plan
   ```

3. **Verify the Namespaces**:
   - Check the namespaces:
     ```bash
     kubectl get namespaces
     ```

---

## Deliverables
- Screenshot of namespaces and roles created via `kubectl`.
- Screenshot of role bindings created via `kubectl`.
---
