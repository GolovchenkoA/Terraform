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
# find PORT(S) like 80:30232/TCP
# curl localhost:30232
resource "kubernetes_service" "example" {
  metadata {
    name = "my-service"
    namespace = "default"
    labels = {
      app = "my-app"
    }
  }

  spec {
    selector = {
      app = "my-app" # This must match your pod or deployment label
    }

    port {
      port        = 80           # Service port
      target_port = 8080         # Container port
      protocol    = "TCP"
    }

    type = "NodePort"            # Or "NodePort", "ClusterIP", "LoadBalancer"
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "my-app"
    labels = {
      app = "my-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-app"
        }
      }

      spec {
        container {
          name  = "web"
          image = "kicbase/echo-server:1.0" # kicbase/echo-server:1.0  or "nginx:alpine"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

