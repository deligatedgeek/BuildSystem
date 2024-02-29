# packer {
#   required_plugins {
#    xenserver= {
#       version = ">= v0.7.0"
#       source = "github.com/ddelnano/xenserver"
#     }
#   }
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