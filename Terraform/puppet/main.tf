#########################################
#  ESXI Provider host/login details
#########################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl  = var.esxi_hostssl
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest resource
#########################################
#
#  This Guest VM is "bare-metal".   It will be powered on by default
#  by terraform, but it will not boot to any OS.   It will however attempt
#  to network boot.
#
resource "esxi_guest" "home-esx-pup-01" {
  guest_name = "home-esx-pup-01" # Required, Specify the Guest Name
  notes      = "Home Puppet Server"
  disk_store = "datastore1"   # Required, Specify an existing Disk Store
  boot_disk_size     = "30"
  boot_disk_type     = "thin"
  boot_firmware      = "bios"
  resource_pool_name = "/"
  memsize            = "2048"
  numvcpus           = "2"
  power              = "on"
  network_interfaces {
    virtual_network = "VM Network" # Required for each network interface, Specify the Virtual Network name.
  }
  # clone_from_vm = "home-test"
  ovf_source = "/home/deligatedgeek/git/BuildSystem/output-home-rock-cloud/packer-home-rock-cloud.ova"
  guestinfo = {
    "metadata.encoding" = "gzip+base64",
    "metadata"          = base64gzip(templatefile("metadata.tpl",{
      HOSTNAME = "home-esx-pup-01"
      address = "192.168.1.21/24"
      gateway = "192.168.254.1"
      ns1     = "192.168.1.1"
      ns2     = "192.168.254.1"
    }))
  }
}
