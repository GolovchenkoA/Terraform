terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
      # version = "~> 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig
}
provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

resource "helm_release" "redis" {
  name       = "redis-cluster"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "19.5.0" # optional: specific chart version

  values = [
    file("values.yaml")
  ]
}