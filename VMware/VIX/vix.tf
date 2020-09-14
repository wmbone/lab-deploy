# https://github.com/hooklift/terraform-provider-vix

#variable "password" {
#     default: ""
#}

provider "vix" {
    # valid options are: "fusion", "workstation", "serverv1", "serverv2", "player"
    # and "workstation_shared"
    product = "workstation"
    verify_ssl = false

    # clone_type can be "full" or "linked". Advantages of one over the other are described here:
    # https://www.vmware.com/support/ws5/doc/ws_clone_typeofclone.html
    clone_type = "linked"
}

resource "vix_vswitch" "vmnet10" {
    name = "vmnet10"
    nat = true
    dhcp = true
    range = "192.168.32.0/24"
    host_access = true
}

resource "vix_vm" "core01" {
    name = "core01"
    description = "Terraform VMWARE VIX test"

    # The provider will download, verify, decompress and untar the image. 
    # Ideally you will provide images that have VMware Tools installed already,
    # otherwise the provider will be considerably limited for what it can do.
    image {
        url = "https://github.com/c4milo/dobby-boxes/releases/download/stable/coreos-stable-vmware.box"
        checksum = "545fec52ef3f35eee6e906fae8665abbad62d2007c7655ffa2ff4133ea3038b8"
        checksum_type = "sha256"

        # If image is encrypted we need to provide a password
        # password = "${var.password}"
    }

    cpus = 1
    # Memory sizes must be provided using IEC sizes such as: kib, ki, mib, mi, gib or gi.
    memory = "1.0gib"
    count = 1
    upgrade_vhardware = false
    #tools_init_timeout = 30s

    # Be aware that GUI does not work if VM is encrypted
    gui = true

    # Whether to enable or disable all shared folders for this VM
    sharedfolders = false

    # Advanced configuration
    network_adapter {
        # type can be either "custom", "nat", "bridged" or "hostonly"
	    #type = "bridged"
	    #mac_address = "00:50:56:aa:bb:cc"

	    # mac address type can be "static", "generated" or "vpx"
	    #mac_address_type = "static"

	    # vswitch is only required when network type is "custom"
	    #vswitch = ${vix_vswitch.vmnet10.name}
	    #start_connected = true
	    #driver = "vmxnet3"
	    #wake_on_lan = false
    }

    # Minimal required
    network_adapter {
	    type = "bridged"
    }
    
    network_adapter {
        type = "nat"
        mac_address = "00:50:56:aa:bb:cc"
        mac_address_type = "static"
    }

    network_adapter {
        type = "hostonly"
    }

    #shared_folder {
    #    enable = false
    #    name = "Dev1"
    #    guest_path = "/home/camilo/dev"
    #    host_path = "/Users/camilo/Development"
    #    readonly = false
    #}
}