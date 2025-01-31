variable "environment" {
  type = list(string)
  default = [ "dev", "beta", "prod" ]
  description = "Environment (aka k8s namespace)"
}

variable "deploy" {
      type = object({
      name = string
      port = number
      image = string
      containerName = string
      replicas = number
    })
    nullable = false
    description = "Deployment definition"
}

variable "cluster" {
      type = object({
      name = string
      nodes = number
    })
    nullable = false
    description = "Cluster definition"
  
}