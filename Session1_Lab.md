# Lab 1: Introduction to Kubernetes

## Overview
This lab introduces Kubernetes, its architecture, and its basic objects. By the end of this session, students will understand the core components of Kubernetes and create their first Pod.

---

## Objectives
- Understand the purpose of Kubernetes and its architecture.
- Explore Kubernetes basic objects: Pods, Nodes, and Services.
- Practice creating Kubernetes resources using YAML.

---

## Instructions

### 1. Prerequisites
Ensure you have the following tools installed:
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)

Start a local Kubernetes cluster using Minikube:
```bash
minikube start
```

Verify the cluster status:
```bash
kubectl cluster-info
```

---

### 2. Kubernetes Architecture
1. Explore the cluster components:
   ```bash
   kubectl get nodes
   kubectl describe node <node-name>
   ```
2. Learn about core components (API Server, Scheduler, kubelet, etc.) using the Kubernetes documentation.

---

### 3. Creating Your First Pod
#### Step 1: Create a YAML file for the Pod
Save the following content to `nginx-pod.yaml`:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    ports:
    - containerPort: 80
```

#### Step 2: Apply the configuration
Run the following command to create the Pod:
```bash
kubectl apply -f nginx-pod.yaml
```

#### Step 3: Verify the Pod is running
```bash
kubectl get pods
kubectl describe pod nginx-pod
```

##### Step 3.1: Create a tunnel to access POD via browser
```bash
kubectl port-forwarding pod nginx-pod 8000:80
curl http://localhost:8000
```

#### Step 4: Clean up the resources
Delete the Pod:
```bash
kubectl delete -f nginx-pod.yaml
```

---

## Exercises
1. **List Nodes and Services:**
   - Run the following command to list the nodes:
     ```bash
     kubectl get nodes
     ```
   - List the services in the cluster:
     ```bash
     kubectl get services
     ```

2. **Create a Custom Pod:**
   - Modify the `nginx-pod.yaml` file to use a different container image (e.g., `httpd:2.4`) and create a new Pod.

---

## Deliverables
- A screenshot of the running Pod.
- YAML file for the custom Pod created in Exercise 2.
