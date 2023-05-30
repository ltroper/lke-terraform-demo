terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}


provider "kubernetes" {
  config_path = "${var.workspace}/kubeconfig.yaml"
}

# provider "kubernetes" {
#   config_path = "${WORKSPACE}/leos-file"
# }

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

resource "kubernetes_network_policy" "example" {
  metadata {
    name      = "cbc-poc"
  }

  spec {
    pod_selector = {
        app = kubernetes_deployment.CBC.spec.0.template.0.metadata.0.labels.app
    }

    ingress {} # single empty rule to allow all ingress traffic

    egress {} # single empty rule to allow all egress traffic

    policy_types = ["Ingress", "Egress"]
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


variable "workspace" {
  description = "set in project vars"
  sensitive   = true
}