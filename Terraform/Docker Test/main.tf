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
resource "esxi_guest" "home-dock-01" {
  guest_name = "home-dock-01" # Required, Specify the Guest Name
  disk_store = "datastore2"   # Required, Specify an existing Disk Store
  boot_disk_size = "100"
  network_interfaces {
    virtual_network = "VM Network" # Required for each network interface, Specify the Virtual Network name.
  }
  # clone_from_vm = "home-test"
  ovf_source = "/home/deligatedgeek/git/BuildSystem/output-home-rock-cloud/packer-home-rock-cloud.ova"
  guestinfo = {
    "metadata.encoding" = "gzip+base64",
    "metadata"          = base64gzip(templatefile("metadata.tpl",{HOSTNAME = "home-dock-01" }))
  }
}
