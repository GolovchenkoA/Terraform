variable "name" {
  description = "App name"
  type        = string
}

variable "image" {
  description = "Container image"
  type        = string
}

variable "replica_count" {
  description = "Number of replicas"
  type        = number
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "service_type" {
  description = "Type of service (ClusterIP, NodePort, LoadBalancer)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}
