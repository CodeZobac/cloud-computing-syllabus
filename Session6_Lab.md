# Session 6: Introduction to Terraform

## Objectives
- Understand Terraform basics.
- Learn how to use the Kubernetes provider in Terraform.

---

## Lab Outline

### Step 1: Setting Up Terraform

1. **Install Terraform**:
   - Download and install Terraform from the [official Terraform website](https://developer.hashicorp.com/terraform/downloads).
   - Verify the installation by running:
     ```bash
     terraform version
     ```

2. **Prepare the Lab Environment**:
   - Ensure you have access to a Kubernetes cluster (e.g., Minikube or Kind).
   - Configure `kubectl` to connect to your cluster.

### Step 2: Understanding the Terraform Basics

1. **Terraform Configuration File**:
   - Review the provided `main.tf` file:
    ```hcl
      provider "minikube" {
    }

    resource "minikube_cluster" "example" {
      cluster_name = "example_cluster"
      nodes=2
    }
    ```

2. **Initialize Terraform**:
   - Run the following command to download required providers:
     ```bash
     terraform init
     ```

3. **Plan and Apply the Configuration**:
   - Preview the changes Terraform will make:
     ```bash
     terraform plan
     ```
   - Apply the configuration to create the namespace:
     ```bash
     terraform apply
     ```

4. **Verify the Namespace**:
   - Check that the namespace has been created:
     ```bash
     kubectl get namespaces
     ```

### Step 3: Deploying a Simple Application

0. **Add Kubernetes Provider connected to minikube cluster**
  - Open `providers.tf` and add the following provider:
  ```hcl
  provider "kubernetes" {
    host = minikube_cluster.example.host
    client_certificate = minikube_cluster.example.client_certificate
    client_key = minikube_cluster.example.client_key
    cluster_ca_certificate = minikube_cluster.example.cluster_ca_certificate
  }
  ```

1. **Review Deployment Configuration**:
   - Open `deployment.tf` to review the configuration for a simple Nginx application:
     ```hcl
     resource "kubernetes_deployment" "nginx" {
       metadata {
         name = "nginx-deployment"
         namespace = kubernetes_namespace.example.metadata[0].name
       }

       spec {
         replicas = 2

         selector {
           match_labels = {
             app = "nginx"
           }
         }

         template {
           metadata {
             labels = {
               app = "nginx"
             }
           }

           spec {
             container {
               image = "nginx:latest"
               name  = "nginx"
               ports {
                 container_port = 80
               }
             }
           }
         }
       }
     }
     ```

2. **Apply the Deployment**:
   ```bash
   terraform apply
   ```

3. **Verify the Deployment**:
   - Check the created pods:
     ```bash
     kubectl get pods -n example-namespace
     ```

4. **Test the Application**:
   - Forward the port to access the application:
     ```bash
     kubectl port-forward svc/nginx-service 8080:80 -n example-namespace
     ```
   - Open a browser and navigate to `http://localhost:8080` to see the Nginx welcome page.

---

## Deliverables
- Screenshot of the namespace and deployment listed via `kubectl`.
- Screenshot of the Nginx welcome page.
- Commit all Terraform files to your Git repository.

---

## Files Included
1. `main.tf`: Basic namespace creation.
2. `deployment.tf`: Nginx deployment.
3. `variables.tf`: Variables used in the configuration.
4. `.gitignore`: Ignoring Terraform state files.

---