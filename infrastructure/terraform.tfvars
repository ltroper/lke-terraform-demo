
k8s_version = "1.26"
label = "lke-tf-jenkins"
region = "us-east"
pools = [
  {
    type : "g6-standard-2"
    count : 3
  }
]
