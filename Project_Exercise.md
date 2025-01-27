# Terraform Project: Multi-Client Kubernetes Cluster with Odoo Deployment

## Project Objective

Develop a comprehensive Terraform project that meets the following advanced requirements:

## Project Requirements

- [ ] Create a flexible infrastructure that supports deployment for three distinct clients:
  - Netflix
  - Meta
  - Rockstar
- [ ] Implement client-specific configuration mechanisms using variables and workspaces

### Kubernetes Cluster Requirements

- [ ] Deploy a Kubernetes cluster using Minikube
- [ ] Ensure robust and scalable cluster configuration
- [ ] Support dynamic namespace creation

### Dynamic Namespace Management

- [ ] Develop a flexible mechanism to create multiple Kubernetes namespaces
- [ ] Support dynamic namespace generation (**e.g., dev, qa, prod**)

### Odoo Application Deployment

- [ ] Implement Terraform resources for Odoo application deployment
- [ ] Configure necessary Kubernetes services and dependencies
- [ ] Ensure application stability across different environments

### Production HTTPS Access

- [ ] Implement secure HTTPS access for the Odoo application in production environments
- [ ] Utilize Ingress and services for HTTPS traffic management
- [ ] Configure SSL/TLS certificates

### Documentation Requirements

- [ ] Generate comprehensive project documentation using terraform-docs
- [ ] Include detailed information about:
    - [ ] Project structure
    - [ ] Variable definitions and purposes
    - [ ] Deployment instructions
    - [ ] Dependencies and prerequisites

## Deliverables

  - [ ] Complete Terraform source code in a folder `TF_PROJECT` inside this repository (**0.5 points**)
  - [ ] Code (**15 points detailed in [Code Evaluation Criteria](#code-evaluation-criteria)**) 
  - [ ] Project documentation with Step-by-step deployment and testing instructions (**3.5 points**)
  - [ ] Creation of a git tag (**0.5 points**)
  - [ ] Text file in Google Drive pointing to your created tag github page (**0.5 points**)

### Code Evaluation Criteria
  - [ ] Code quality and organization (**5 points**)
  - [ ] Flexibility and scalability of the solution (**3 points**)
  - [ ] Adherence to Terraform best practices for multiple clients (aka. workspaces) (**3 points**)
  - [ ] Comprehensive documentation (**2 points**)
  - [ ] Successful deployment across different client scenarios (**2 points**)
