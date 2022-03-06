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
  vnc_over_websocket = "true"
  insecure_connection = "true"
  network_name = "VM Network"
  skip_export = "true"
  iso_url = "http://192.168.1.5/repo/Rocky-8.5-x86_64-boot.iso"
  iso_checksum = "sha256:5a0dc65d1308e47b51a49e23f1030b5ee0f0ece3702483a8a6554382e893333c"
  #communicator = "none"
  keep_registered = "true"
  boot_command = [
    #"<wait10m>e<down><down><down><left><del><del><del><del><del>",
    "<up><up<tab><bs><bs><bs><bs><bs>",
    "inst.repo=http://192.168.1.5/repo/Linux/Rocky-8.5-x86_64/ ",
    "inst.ks=http://192.168.1.5/kickstart/home-esx-rock.ks ",
    "<enter>"
    #"<leftCtrlOn>c<leftCtrlOff>",
    #"debian-installer=en_US auto locale=en_US kbd-chooser/method=us ",
    #"hostname={{ .Name }} ",
    #"fb=false debconf/frontend=noninteractive ",
    #"keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ",
    #"keyboard-configuration/variant=USA console-setup/ask_detect=false ",
    #"initrd=/install/initrd.gz -- <enter>"
  ]

  ssh_username = "packer"
  ssh_password = "packer"
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.vmware-iso.home-rock"]
}
