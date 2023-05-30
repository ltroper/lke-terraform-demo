terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}


# provider "kubernetes" {
#   config_path = "~/.kube/cbcPOC"
# }

provider "kubernetes" {
  config_path = "${WORKSPACE}/leos-file"
}

resource "kubernetes_deployment" "CBC" {
  metadata {
    name = "cbc-poc"
    labels = {
      test = "CBCPOC"
      app  = "CBC-poc"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "CBC-poc"
      }
    }

    template {
      metadata {
        labels = {
          app = "CBC-poc"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "cbc-poc"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "CBC" {
  metadata {
    name = "cbc-poc"
    labels = {
      test = "CBCPOC"
      app  = "CBC-poc"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.CBC.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port = 80
    }
  }
}
