terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}


provider "kubernetes" {
  config_path = "~/.kube/tickTradeConfig"
}

resource "kubernetes_deployment" "tickTrade" {
  metadata {
    name = "tick-trade-poc"
    labels = {
      test = "tickTradePOC"
      app  = "tick-trade-poc"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "tick-trade-poc"
      }
    }

    template {
      metadata {
        labels = {
          app = "tick-trade-poc"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "tick-trade-poc"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "tickTrade" {
  metadata {
    name = "tick-trade-poc"
    labels = {
      test = "tickTradePOC"
      app  = "tick-trade-poc"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.tickTrade.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port = 80
    }
  }
}
