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
resource "esxi_guest" "vmtestrehostname" {
  guest_name = "home-rock-03" # Required, Specify the Guest Name
  disk_store = "datastore1"   # Required, Specify an existing Disk Store
  network_interfaces {
    virtual_network = "VM Network" # Required for each network interface, Specify the Virtual Network name.
  }
  # clone_from_vm = "home-test"
  ovf_source = "/home/deligatedgeek/git/BuildSystem/output-home-rock-cloud/packer-home-rock-cloud.ova"
  guestinfo = {
    "metadata.encoding" = "gzip+base64",
    "metadata"          = base64gzip(templatefile("metadata.tpl",{HOSTNAME = "home-rock-03" }))
  }
}
