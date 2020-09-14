# Reference for Terraform VMware

##Example
- Vsphere
https://github.com/diodonfrost/terraform-vsphere-examples

https://github.com/sguyennet/terraform-vsphere-standalone

https://github.com/hashicorp/terraform-provider-vsphere/tree/master/examples



-use iginition to provision template 
https://github.com/hashicorp/terraform-provider-vsphere/tree/master/examples

###Doc
https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/content_library
https://registry.terraform.io/modules/vancluever/virtual-machine/vsphere/1.0.1
https://github.com/vancluever/terraform-vsphere-virtual-machine



####Pulling meta with Cloud-init
https://github.com/vmware/cloud-init-vmware-guestinfo
https://github.com/canonical/cloud-init

##### ESXi provider
https://github.com/josenk/terraform-provider-esxi
https://github.com/hooklift/terraform-provider-vix

https://github.com/hashicorp/terraform-provider-vsphere/issues/462

@yaoBohoussou, pfSense runs FreeBSD, and BSD operating systems have a known issue where their version of VMware tools do not correctly report a gateway address. Unfortunately this means that you won't be able to set wait_for_guest_net_timeout to an enabled value at this time.

This will be fixed in future versions. In the meantime, you should be able to get the IP addressing data in a different resource (such as null_resource) and just run the provisioner there:

resource "null_resource" "vm_post_deploy" {
  ...
  connection {
    host = "${vsphere_virtual_machine.rtr.default_ip_address}"
  }

  provisioner "remote-exec" {
    inline ["uname -a"]
  }
}

- troubleshooting resource use "govc ls" and "govc find"

- use 