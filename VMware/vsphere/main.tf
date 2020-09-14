provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.vmdatastore
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
#data "vsphere_compute_cluster" "cluster" {
#    name          = "ComputeCluster"
#    datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}
data "vsphere_resource_pool" "pool" {
  name          = "Compute-ResourcePool"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
data "vsphere_virtual_machine" "template" {
  name          = "photon-ova"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


#data "vsphere_content_library" "library" {
#  name          = "lab-image"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

resource "vsphere_license" "licenseKey" {
  license_key = var.vsphere_license

#  labels {
#    VpxClientLicenseLabel = "Lab license"
#    Workflow              = "Lab License"
#  }

}

#resource "vsphere_content_library" "library"{
#    name = var.vsphere_contentlibrary
#    storage_backing= "${data.vsphere_datastore.datastore.id}"
#     storage_backing= "data-01"
#}
resource "vsphere_virtual_machine" "vm" {
    name             = "terraform-test"
#    folder           = "Workloads"
#    resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    resource_pool_id= "${data.vsphere_resource_pool.pool.id}"
    datastore_id     = "${data.vsphere_datastore.datastore.id}"
    firmware         = "${data.vsphere_virtual_machine.template.firmware}"
    num_cpus = 1
    memory   = 1024
    guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
    network_interface {
        network_id   = "${data.vsphere_network.network.id}"
        adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    }
    disk {
        label            = "disk0"
        size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
        eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
        thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    }
    scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
}