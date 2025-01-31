resource"minikube_cluster" "my-cluster" {
    cluster_name = "etic-cluster"
    driver = "docker"
    addons = [
        "ingress"
    ]
    
}