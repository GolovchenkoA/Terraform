
provider "kubernetes" {
  # Assumes your kubeconfig is already setup, or use client config here
  config_path = "~/.kube/config"
}

module "webapp" {
  source          = "./modules/webapp"
  name            = var.name
  image           = var.image
  replica_count   = var.replica_count
  container_port  = var.container_port
  service_type    = var.service_type
  environment     = var.environment
}

resource "kubernetes_deployment" "webapp" {
  metadata {
    name = var.name
    labels = {
      app = var.name
      env = var.environment
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            container_port = var.container_port
          }

          env {
            name  = "ENVIRONMENT"
            value = var.environment
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "webapp_service" {
  metadata {
    name = "${var.name}-service"
    labels = {
      app = var.name
      env = var.environment
    }
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      port        = 80
      target_port = var.container_port
    }

    type = var.service_type
  }
}
