# packer {
#   required_plugins {
#    xenserver= {
#       version = ">= v0.7.0"
#       source = "github.com/ddelnano/xenserver"
#     }
#   }
# }

# locals {
#   timestamp = regex_replace(timestamp(), "[- TZ:]", "") 
# }

# source "xenserver-iso" "centos8-netinstall" {
#   iso_checksum      = "sha256:9602c69c52d93f51295c0199af395ca0edbe35e36506e32b8e749ce6c8f5b60a"
#   iso_url           = "https://mirror.cs.pitt.edu/centos-vault/8.5.2111/isos/x86_64/CentOS-8.5.2111-x86_64-boot.iso"

#   sr_iso_name    = var.sr_iso_name
#   sr_name        = var.sr_name
#   tools_iso_name = "guest-tools.iso"

#   remote_host     = var.remote_host
#   remote_password = var.remote_password
#   remote_username = var.remote_username

#   vm_name        = "packer-centos8-netinstall-${local.timestamp}"
#   vm_description = "Build started: ${local.timestamp}\n This was installed with an external repository"
#   vm_memory      = 2048
#   disk_size      = 20000
#   network_names  = ["LDP02-AUTOINSTALL-412"]

#   http_directory = "http"
#   boot_command   = [
#     "<up><up<tab><bs><bs><bs><bs><bs>",
#     "inst.repo=https://mirror.cs.pitt.edu/centos-vault/8.5/BaseOS/x86_64/os/ ",
#     "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.ks ",
#     "<enter>"
#   ]
#   boot_wait      = "10s"

#   ssh_username     = var.build_user
#   ssh_password     = var.build_password
#   ssh_wait_timeout = "20m"

#   format = "none"
#   output_directory = "test"
#   keep_vm          = "always"
# }

# build {
#   sources = ["xenserver-iso.centos8-netinstall"]
# }

packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "home-rock" {
  remote_type = "esx5"
  remote_host = var.esx_host
  remote_password = var.esx_password
  cpus = "2"
  memory = "2048"
  guest_os_type = "centos-64"
  vnc_over_websocket = "true"
  insecure_connection = "true"
  network_name = "VM Network"
  skip_export = var.skip_export
  http_directory = "/Users/mark.ottaway/git/mine/BuildSystem/Packer/CentOS/http"
  iso_url = "https://mirror.cs.pitt.edu/centos-vault/8.5.2111/isos/x86_64/CentOS-8.5.2111-x86_64-boot.iso"
  iso_checksum = "sha256:9602c69c52d93f51295c0199af395ca0edbe35e36506e32b8e749ce6c8f5b60a"
  #communicator = "none"
  #keep_registered = "true"
  boot_command = [
    #"<wait10m>e<down><down><down><left><del><del><del><del><del>",
    "<up><up<tab><bs><bs><bs><bs><bs>",
    "inst.repo=https://mirror.cs.pitt.edu/centos-vault/8.5/BaseOS/x86_64/os/ ",
    "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.ks ",
    "<enter>"
    #"<leftCtrlOn>c<leftCtrlOff>",
    #"debian-installer=en_US auto locale=en_US kbd-chooser/method=us ",
    #"hostname={{ .Name }} ",
    #"fb=false debconf/frontend=noninteractive ",
    #"keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ",
    #"keyboard-configuration/variant=USA console-setup/ask_detect=false ",
    #"initrd=/install/initrd.gz -- <enter>"
  ]
  format = "ova"
  output_directory = "./"
  ssh_username = var.build_user
  ssh_password = var.build_password
  ssh_timeout = "20m"
  ssh_keep_alive_interval = "30s"
  shutdown_command = "rm -f /etc/cloud/cloud-init.disabled;shutdown -P now"
}

build {
  sources = ["sources.vmware-iso.home-rock"]
}