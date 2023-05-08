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
resource "linode_lke_cluster" "CBC" {
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


locals {
  kubeconfig = base64decode(linode_lke_cluster.CBC.kubeconfig)
}

resource "null_resource" "write_kubeconfig" {
  provisioner "local-exec" {
    command = "mkdir ~/.kube && echo '${local.kubeconfig}' > ~/.kube/cbcPOC"
  }
}



//Export this cluster's attributes
output "kubeconfig" {
  value     = linode_lke_cluster.CBC.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.CBC.api_endpoints
}

output "status" {
  value = linode_lke_cluster.CBC.status
}

output "id" {
  value = linode_lke_cluster.CBC.id
}

output "pool" {
  value = linode_lke_cluster.CBC.pool
}



variable "token" {}
variable "pass" {}
variable "k8s_version" {}
variable "label" {}
variable "region" {}
variable "pools" {}
