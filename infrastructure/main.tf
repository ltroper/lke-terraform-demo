terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.27.1"
    }
  }
}
//Use the Linode Provider
provider "linode" {
  token = var.token
}

//Use the linode_lke_cluster resource to create
//a Kubernetes cluster
resource "linode_lke_cluster" "tickTrade" {
  k8s_version = var.k8s_version
  label       = var.label
  region      = var.region

  dynamic "pool" {
    for_each = var.pools
    content {
      type  = pool.value["type"]
      count = pool.value["count"]
    }
  }


}


<<<<<<< HEAD
# locals {
#   kubeconfig = base64decode(linode_lke_cluster.CBC.kubeconfig)
# }

# resource "null_resource" "write_kubeconfig" {
#   provisioner "local-exec" {
#     command = "mkdir ~/.kube && echo '${local.kubeconfig}' > ~/.kube/cbcPOC"
#   }
# }




=======
locals {
  kubeconfig = base64decode(linode_lke_cluster.tickTrade.kubeconfig)
}

resource "null_resource" "write_kubeconfig" {
  provisioner "local-exec" {
    command = "mkdir ~/.kube && echo '${local.kubeconfig}' > ~/.kube/tickTradeConfig"
  }
}
>>>>>>> parent of 80efc16 (changing names)



//Export this cluster's attributes
output "kubeconfig" {
<<<<<<< HEAD
  value     = base64decode(linode_lke_cluster.CBC.kubeconfig)
=======
  value     = linode_lke_cluster.tickTrade.kubeconfig
>>>>>>> parent of 80efc16 (changing names)
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.tickTrade.api_endpoints
}

output "status" {
  value = linode_lke_cluster.tickTrade.status
}

output "id" {
  value = linode_lke_cluster.tickTrade.id
}

output "pool" {
  value = linode_lke_cluster.tickTrade.pool
}



variable "token" {
  description = "set in project vars"
  sensitive   = true
}
variable "pass" {
  description = "set in project vars"
  sensitive   = true
}
variable "k8s_version" {}
variable "label" {}
variable "region" {}
variable "pools" {}
