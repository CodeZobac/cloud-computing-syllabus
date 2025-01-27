# Cloud Computing Module Outline

## Session 1: Introduction to Kubernetes

### Objectives
- Understand what Kubernetes is and its purpose.
- Learn about Kubernetes architecture and its core components.
- Explore basic Kubernetes objects: Pods, Nodes, and Services.

### Content
#### 1. What is Kubernetes?
Kubernetes is an open-source container orchestration system that automates the deployment, scaling, and operation of application containers. For more details, visit the [Kubernetes official documentation](https://kubernetes.io/docs/).

#### 2. Kubernetes Architecture
Key components:
- **Master Node**: Manages the cluster (API Server, Scheduler, Controller Manager, etc.).
- **Worker Node**: Runs application workloads (kubelet, kube-proxy, container runtime).
- **etcd**: Stores cluster data.

![Kubernetes Architecture](https://kubernetes.io/images/kubernetes-architecture.svg)

#### 3. Basic Objects in Kubernetes
- **Pods**: Smallest deployable units.
- **Nodes**: Machines that run workloads.
- **Services**: Enable communication within the cluster or with external clients.

### Exercises
1. Create a pod manually using a YAML file.
2. List the nodes and services in a running Kubernetes cluster.

---

## Session 2: Managing Applications in Kubernetes

### Objectives
- Deploy and manage scalable applications.
- Use ConfigMaps and Secrets.
- Expose services using LoadBalancer and NodePort.

### Content
#### 1. Deployments and ReplicaSets
Deployments manage the lifecycle of Pods and ensure replicas are running. Read more in the [Deployments documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).

#### 2. ConfigMaps and Secrets
- **ConfigMaps** store configuration data as key-value pairs.
- **Secrets** store sensitive data like passwords and keys.

#### 3. Exposing Services
Use Service types:
- ClusterIP
- NodePort
- LoadBalancer

### Exercises
1. Create a deployment with at least 3 replicas using a YAML file.
2. Configure a ConfigMap and mount it into the pods.
3. Expose created deployment.

---

## Session 3: Storage in Kubernetes

### Objectives
- Understand Kubernetes volume types.
- Work with Persistent Volumes (PVs) and Persistent Volume Claims (PVCs).
- Use StatefulSets for managing stateful applications.

### Content
#### 1. Volumes in Kubernetes
- **emptyDir**: Temporary storage.
- **hostPath**: Storage on the host.
- **Persistent Volumes (PV) and Claims (PVC)**: Long-term storage abstraction.

#### 2. StatefulSets
Use StatefulSets for applications that require unique network identities and persistent storage. Learn more [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).

### Exercises
1. Create a PVC and attach it to a pod.
2. Deploy a StatefulSet for a database service.

---

## Session 4: Networking in Kubernetes

### Objectives
- Understand networking basics in Kubernetes.
- Learn about Ingress controllers and DNS within a cluster.

### Content
#### 1. Kubernetes Networking Model
Kubernetes uses a flat networking model where all Pods can communicate with each other. Learn more [here](https://kubernetes.io/docs/concepts/cluster-administration/networking/).

#### 2. Ingress
Ingress exposes HTTP and HTTPS routes to services. Documentation [here](https://kubernetes.io/docs/concepts/services-networking/ingress/).

### Exercises
1. Configure an Ingress to expose an application.
2. Set up a DNS entry to access the application.

---

## Session 5: Kubernetes Revision

### Objectives
- Review Kubernetes concepts covered so far.
- Solve practical exercises to consolidate knowledge.

### Content
#### 1. Application Lifecycle in Kubernetes
- Deployments
- Scaling
- Updates

#### 2. Advanced Topics Review
- Volumes
- Networking
- Ingress

### Exercises
1. Create a multi-tier application using all learned concepts.

---

## Session 6: Introduction to Terraform

### Objectives
- Understand Terraform basics.
- Learn how to use the Kubernetes provider in Terraform.

### Content
#### 1. What is Terraform?
Terraform is an Infrastructure as Code (IaC) tool for defining and provisioning resources. Documentation [here](https://developer.hashicorp.com/terraform/docs).

#### 2. Terraform Basics
- Providers
- Resources

### Exercises
1. Create a minikube cluster using Terraform using its [provider](https://registry.terraform.io/providers/scott-the-programmer/minikube/latest/docs)

---

## Session 7: Automating Kubernetes dynamically with Terraform using variables

### Objectives
- Automate cluster creation and management with Terraform.
- Use Terraform to configure namespaces and deployments using variables.

### Content
#### 1. Automating Minikube/Kind Clusters
- [Minikube](https://minikube.sigs.k8s.io/docs/).

#### 2. Terraform Resources for Kubernetes
- Namespaces
- Deployments

#### 3. Configure variables
- To declare variables please take a look into [documentation](https://developer.hashicorp.com/terraform/language/values/variables)
- to assign values to variables you need to create a `[NAME].tfvars` file. Follow [here](https://developer.hashicorp.com/terraform/language/values/variables#assigning-values-to-root-module-variables)

### Exercises
1. Create a cluster with Minikube using Terraform.
2. Automate namespace creation.

---

## Session 8: Complete dynamic Terraform creation by managing multiple states

### Objectives
- Manage complex Kubernetes resources using Terraform and Terraform [workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces) for managing multiples [states](https://developer.hashicorp.com/terraform/language/state)
- Handle variables and outputs effectively.

### Content
#### 1. Advanced Terraform Features
- Variables
- Workspaces

### Exercises
1. Create multiple workspaces using Terraform.
2. Configure a cluster and a deployment for each workspace
---

## Session 9: Terraform Revision

### Objectives
- Review Terraform concepts and troubleshoot common issues.
- Consolidate Terraform knowledge with practical exercises.

### Content
#### 1. Review Topics
- Resource creation
- Outputs and variables

### Exercises
1. Develop a complete application in Kubernetes using Terraform.

---

## Sessions 10-11: Final Project Development

### Objectives
- Develop and deploy a full application using Kubernetes and Terraform.
- Kubernetes cluster should be created via Terraform
- Application workloads should also be created via Terraform

- Project must be in a public github repository and you should deliver a text file in Cloud Computing '03_Projectos Final/[YOUR NAME]' Google Drive folder.

- Deliver must be done (both file upload and git commits) until 23h59 of the module's last session day 

### Content
#### 1. Project Requirements
- Multi-tier application architecture.
- Automation with Terraform.

#### 2. Development Phases
- Initial setup.
- Resource creation.
- Automation Process and Validation.

### Exercises
1. Build and deploy the final project.
2. Document the project.

