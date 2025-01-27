# Session 8: Advanced Kubernetes with Terraform

## Objectives
- Manage complex Kubernetes resources using Terraform.
- Handle multiple terraform states with workspaces

---

## Lab Outline

> [!INFO]
> Consider this lab as having the same terraform to be applied
> in multiple different clients, with differents parameter for each one.

### Step 1: Preparing the Environment

1. **Install Required Tools**:
   - Ensure Terraform is installed (refer to Session 6 if needed).
   - Ensure a Kubernetes cluster is created.

2. **Prepare the Lab Environment**:
   - Configure `kubectl` to interact with the cluster:
     ```bash
     kubectl cluster-info
     ```

---

### Step 2: Adapt tfvars for clients and confure Workspaces

1. **Adapt variables**:
   - Configure `clientA.tfvars`:
     ```hcl
     environments = ["dev", "prod", "beta"]
     app = {
      name = "next-app"
      image = "nginx:alpine"
      replicas = 2
      port = 80
     }
     ```
   - Configure `clientB.tfvars`:
     ```hcl
     environments = ["dev", "beta"]
     app = {
      name = "next-app"
      image = "nginx:alpine"
      replicas = 2
      port = 80
     }
     ```

2. **Initialize and Apply the Configuration for each client**:
   - For client A:
     ```bash
     terraform workspace new clienta
     terraform init
     terraform plan -var-file=clientA.tfvars -out a.plan
     terraform apply a.plan
     ```
   - For client B:
     ```bash
     terraform workspace new clientb
     terraform init
     terraform plan -var-file=clientB.tfvars -out b.plan
     terraform apply b.plan
     ```

3. **Verify the StatefulSet**:
   - Check the StatefulSet and Pods:
     ```bash
     kubectl get ns,deploy,pod -A # -A makes you list from all namespaces
     ```

---

## Deliverables
- **Screenshots**:
  1. StatefulSet and Pods created via Terraform (`kubectl get statefulsets/pods`).
  2. Ingress resource created (`kubectl get ingress`).
