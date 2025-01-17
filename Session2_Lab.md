# Lab 2: Managing Applications in Kubernetes

## Overview
This lab focuses on deploying and managing scalable applications in Kubernetes. Students will learn to use ConfigMaps, Secrets, and different Service types to expose their applications.

---

## Objectives
- Deploy and manage scalable applications using Deployments and ReplicaSets.
- Use ConfigMaps and Secrets to manage configuration and sensitive data.
- Expose applications using Service types: LoadBalancer and NodePort.

---

## Instructions

### 1. Prerequisites
Ensure you have a running Kubernetes cluster (e.g., Minikube) and `kubectl` configured. Start Minikube if needed:
```bash
minikube start
```

---

### 2. Deploying an Application
#### Step 1: Create a Deployment
Save the following content to `nginx-deployment.yaml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
        ports:
        - containerPort: 80
```

or via kubectl
```bash
kubectl create deployment nginx-deployment --image nginx:1.21 --port 80
```

Apply the configuration:
```bash
kubectl apply -f nginx-deployment.yaml
```

Verify the Deployment and Pods:
```bash
kubectl get deployments
kubectl get pods
```

---

### 3. Using ConfigMaps and Secrets
#### Step 1: Create a ConfigMap
Save the following content to `app-config.yaml`:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_ENV: "production"
  APP_DEBUG: "false"
```

or 

```bash
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=APP_DEBUG=false
```

Apply the ConfigMap:
```bash
kubectl apply -f app-config.yaml
```

#### Step 2: Use the ConfigMap in a Pod
Modify the `nginx-deployment.yaml` file to mount the ConfigMap:
```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    env:
    - name: APP_ENV
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: APP_ENV
    - name: APP_DEBUG
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: APP_DEBUG
```
Update the Deployment:
```bash
kubectl apply -f nginx-deployment.yaml
```

#### Step 3: Create a Secret
Save the following content to `app-secret.yaml`:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
stringData:
  DB_PASSWORD: "mysecretpassword"
```

or via kubectl

```bash
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=mysecretpassword
```

Apply the Secret:
```bash
kubectl apply -f app-secret.yaml
```

---

### 4. Exposing the Application
#### Step 1: Create a Service
Save the following content to `nginx-service.yaml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: NodePort
```
or

```bash
kubectl expose deployment nginx --target-port=80 --type NodePort
```

Apply the Service:
```bash
kubectl apply -f nginx-service.yaml
```

#### Step 2: Access the Application
Get the NodePort:
```bash
kubectl get service nginx-service
```
Access the application using the Minikube IP and NodePort:
```bash
minikube service nginx-service
```

---

## Exercises
1. **Create a ConfigMap:**
   - Add a new key-value pair to `app-config.yaml` and update the Deployment to use it.
2. **Create a Secret:**
   - Modify the Secret to include another sensitive key (e.g., `API_KEY`).
3. **Expose Deployment:**
   - Change the Service type to `LoadBalancer` and observe the difference.

---

## Deliverables
- Screenshots of the Deployment and Service running.
- YAML files for the updated ConfigMap, Secret, and Service.
