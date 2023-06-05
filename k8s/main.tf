terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
      linode = {
      source  = "linode/linode"
      version = "1.27.1"
    }
  }
}


provider "kubernetes" {
<<<<<<< HEAD
  config_path = "${var.workspace}/kubeconfig.yaml"
}

# provider "kubernetes" {
#   config_path = "${WORKSPACE}/leos-file"
# }

resource "kubernetes_deployment" "CBC" {
  metadata {
    name = "cbc-poc"
=======
  config_path = "~/.kube/tickTradeConfig"
}

resource "kubernetes_deployment" "tickTrade" {
  metadata {
    name = "tick-trade-poc"
>>>>>>> parent of 80efc16 (changing names)
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
<<<<<<< HEAD
          name  = "cbc-poc"
=======
          name  = "tick-trade-poc"
>>>>>>> parent of 80efc16 (changing names)
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

<<<<<<< HEAD
# resource "kubernetes_network_policy" "example" {
#   metadata {
#     name      = "cbc-poc"
#   }

#   spec {
#     pod_selector {
#       match_labels = {
#         app = kubernetes_deployment.CBC.spec.0.template.0.metadata.0.labels.app
#       }
#     }

#     ingress {} # single empty rule to allow all ingress traffic

#     egress {} # single empty rule to allow all egress traffic

#     policy_types = ["Ingress", "Egress"]
#   }
# }

resource "kubernetes_service" "CBC" {
  metadata {
    name = "cbc-poc"
=======
resource "kubernetes_service" "tickTrade" {
  metadata {
    name = "tick-trade-poc"
>>>>>>> parent of 80efc16 (changing names)
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

resource "linode_domain" "exampleDomain" {
  domain    = "splitfare.io"
  soa_email = "gabrielmermelstein@gmail.com"
  type      = "master"
}

resource "linode_domain_record" "exampleDomainRec" {
  domain_id   = linode_domain.exampleDomain.id
  name        = "www.splitfare.io"
  record_type = "A"
  target      = kubernetes_service.CBC.ip_address
  ttl_sec     = 300
}


variable "workspace" {
  description = "set in project vars"
  sensitive   = true
}