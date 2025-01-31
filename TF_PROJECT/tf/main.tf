// This example assumes you have Minikube running locally and the ~/.kube/config is set.

locals {
  active_workspace = terraform.workspace
  client_name      = local.active_workspace != "default" ? local.active_workspace : "General"
}

// You can create multiple workspaces using:
// terraform workspace new Netflix
// terraform workspace new Meta
// terraform workspace new Rockstar

resource "null_resource" "start_minikube" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Starting Minikube..."
      minikube start
    EOT
  }
}

// For demonstration, we simply read which workspace is active
output "current_client" {
  value = local.client_name
}

// (Optional) If you want to automate minikube creation or rely on an external provider, 
// you could add a resource block or instructions here to ensure cluster creation, 
// but typically Minikube is started outside of Terraform.