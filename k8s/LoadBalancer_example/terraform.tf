terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config" # or use in-cluster or exec auth if running inside k8s
}

# How to connect to the service
# > kubectl get services -o wide
# find EXTERNAL-IP and PORT(S) like 80:XXXX/TCP
# curl -H "Connection: close" <EXTERNAL-IP>:<PORT>
# curl -H "Connection: close" localhost:80

# Deployment with multiple replicas (for load balancing)
# Deployment
resource "kubernetes_deployment" "webapp" {
  metadata {
    name = "webapp"
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          name  = "web"
          image = "jmalloc/echo-server" # Responds with hostname
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# LoadBalancer Service
resource "kubernetes_service" "webapp_lb" {
  metadata {
    name = "webapp-service"
    labels = {
      app = "webapp"
    }
  }

  spec {
    selector = {
      app = "webapp"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

