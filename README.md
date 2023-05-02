# LKE + Terraform Demo

This demo uses Terraform to spin up infrastructure on Linode and deploy a Kubernetes cluster using Linode Kubernetes Engine (LKE).

The demo is split into two directories:

- infrastructure: contains the Terraform code to spin up the infrastructure, including the LKE cluster.
- k8s: contains the Terraform code to deploy the Kubernetes environment, including a deployment and a service


## Prerequisites
Before starting this demo, you should have the following:

- Linode account
- Linode Personal Access Token (PAT) with the following scopes: linodes:read_write, lke:read_write
- The Terraform CLI installed on your machine

## SetUp
1. Clone this repository to your local machine:

```

```


## Important Notes

- You will need a Linode account and an API token to use this demo.
- The Terraform configurations provided in this demo are for demonstration purposes only and are not production-ready. It is recommended that you review and modify the configurations to meet your specific requirements before using them in a production environment.
- The demo uses a null_resource with a local-exec provisioner to write the kubeconfig to a file. This is not recommended for production use, and it is recommended that you use a more secure method to manage your kubeconfig.
- This demo assumes that you have already installed and configured Terraform on your local machine. If you have not done so, please refer to the Terraform documentation for instructions.
