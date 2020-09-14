variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" {}
variable "vsphere_contentlibrary" {}
variable "vsphere_license" {}

# VM
variable "vmname" {}
variable "vmhostname" {}
# Resource Pool
variable "vmrp" {
    default = "Compute-ResourcePool"
}
# VM domain for guest customization
variable "vmdomain" {
    default = "lab.local"
}
variable "vmdatastore" {
    default = "data-01"
}
variable "vmtemplate" {
    default = "photon"
}