namespaces = [ "dev", "qa", "prod" ]
app = {
    containerName = "app"
    image = "nginx:latest"
    name = "app"
    port = 80
    replicas = {
        DEV = 1
        QA = 2
        PROD = 3
    }
}