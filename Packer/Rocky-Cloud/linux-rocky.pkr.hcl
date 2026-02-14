packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "home-rock-cloud" {
  remote_type = "esx5"
  remote_host = var.esx_host
  remote_password = var.esx_password
  cpus = "2"
  memory = "2048"
  guest_os_type = "centos9-64"
  vnc_over_websocket = "true"
  insecure_connection = "true"
  network_name = "VM Network"
  skip_export = var.skip_export
  http_directory = "./http"
  iso_url = "https://dl.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9-latest-x86_64-boot.iso"
  iso_checksum = "sha256:3b5c87b2f9e62fdf0235d424d64c677906096965aad8a580e0e98fcb9f97f267"
  boot_wait = "5s"
  boot_command = [
    "<wait><up><tab>",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.ks",
    "<enter>"
  ]
  vm_name = "packer-home-rock9-cloud"
  format = "ova"
  output_directory = "../../ova"
  ssh_username = var.build_user
  ssh_password = var.build_password
  ssh_timeout = "30m"
  ssh_keep_alive_interval = "30s"
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.vmware-iso.home-rock-cloud"]

  provisioner "shell" {
    inline = [
      "rm -f /etc/cloud/cloud-init.disabled",
      "cloud-init clean --logs"
    ]
  }
}
