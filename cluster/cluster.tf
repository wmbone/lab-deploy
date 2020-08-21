provider "kind" {}

variable "PodIPrange" {
    type = string
    default = "10.244.0.0/16"
}
variable "ServiceIPrange" {
    type = string
    default = "10.96.0.0/12"
}

resource "kind_cluster" "default" {
    name = "lab-cluster"
    node_image = "kindest/node:v1.18.4"
    wait_for_ready = true
    kind_config =<<KIONF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
#  networking:
#    podSubnet: var.PodIPrange
#    serviceSubnet   var.ServiceIPrange
nodes:
- role: control-plane
- role: worker
- role: worker
KIONF
}