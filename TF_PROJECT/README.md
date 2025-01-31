# Odoo on Kubernetes Deployment Project Using Terraform

## 📋 Table of Contents
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Variables Overview](#-variables-overview)
- [Deployment Guide](#-deployment-guide)
- [Makefile Automation](#-makefile-automation)
- [Access & Verification](#-access--verification)
- [Troubleshooting](#-troubleshooting)

## 🗂️ Project Structure
├── [README.md](README.md)
├── scripts
│   └── [generate_docs.sh](scripts/generate_docs.sh)
└── tf
    ├── [database.tf](tf/database.tf)
    ├── [main.tf](tf/main.tf)
    ├── [Makefile](tf/Makefile)
    ├── [namespaces.tf](tf/namespaces.tf)
    ├── [netflix.plan](tf/netflix.plan)
    ├── [odoo.tf](tf/odoo.tf)
    ├── [outputs.tf](tf/outputs.tf)
    ├── [provider.tf](tf/provider.tf)
    ├── [terraform.tfstate](tf/terraform.tfstate)
    ├── clients
    │   ├── netflix
    │   │   ├── [Netflix.tfvars](tf/clients/Netflix.tfvars)
    │   └── rockstar
    │       └── [Rockstar.tfvars](tf/clients/Rockstar.tfvars)
    │       └── [Meta.tfvars](tf/clients/Meta.tfvars)
    └── [variables.tf](tf/variables.tf)


## ⚙️ Prerequisites
- **Minikube** (local Kubernetes cluster)
- **Terraform** v1.0.0+
- **kubectl** (Kubernetes CLI)
- **PostgreSQL Client** (for database checks)

### Installation Guide
```bash
# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install Terraform
sudo apt-get update && sudo apt-get install terraform

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## 📊 Variables Overview
| Variable     | Description                        | Default Value                     |
|--------------|------------------------------------|-----------------------------------|
| clients      | List of client names               | ["Netflix", "Meta", "Rockstar"]   |
| envs         | Deployment environments            | None (required in .tfvars)        |
| replicas     | Replica count per environment      | None (required in .tfvars)        |
| odoo_image   | Odoo container image               | odoo:16.0                         |
| enable_https | Enable HTTPS for production        | true                              |

## 🚀 Deployment Guide

### 1. Initialize Workspaces
```bash
make start  # Creates Netflix, Meta, Rockstar workspaces
```
### 2. Select Workspace
```bash
make select-workspace
# Choose from: Netflix, Meta, Rockstar
```
### 3. Plan Infrastructure
```bash
make plan  # Generates execution plan
```
### 4. Apply Configurations
```bash 
make apply  # Deploys resources to selected workspace
```
### 5. Add New Environment
```bash
make add-env
# Example: Create "staging" with 2 replicas
```

## 🤖 Makefile Automation Cheat Sheet
```bash
# Create new client workspace
make create-workspace

# List all workspaces
make list-workspaces

# Destroy current workspace resources
make destroy

# Generate documentation
make docs
```

## 🔍 Access & Verification
### Check Deployment Status
```bash
kubectl get pods -n <workspace>-<env>
# Example: kubectl get pods -n netflix-prod
```
### View Odoo Logs
```bash
kubectl logs <odoo-pod-name> -n <namespace> -c odoo
```
### Verify PostgreSQL Connection
```bash
kubectl exec -it <postgres-pod> -n <namespace> -- \
  psql -U odoo -d postgres
```

## 🚨 Troubleshooting
### Common Issues
### Database Connection Failures

```bash
kubectl logs <postgres-pod> -n <namespace>
kubectl describe pod <odoo-pod> -n <namespace>
```
### Pending Pods

```bash
kubectl describe pod <pod-name> -n <namespace>
kubectl get events --sort-by=.metadata.creationTimestamp
```
### Ingress Issues
```bash
minikube addons enable ingress
kubectl get ingress -n <namespace>
```
### Reset Environment
```bash
make destroy
minikube delete
make start
```
**💡 Pro Tip: Always run make plan before make apply to preview changes!**




**DISCLAIMER PROJETO NÃO FUNCIONA**



