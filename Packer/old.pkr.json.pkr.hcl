
source "vmware-iso" "ubuntu-1604-base" {
  boot_command        = ["<enter><wait><f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "/install/vmlinuz noapic ", "preseed/file=/floppy/ubuntu.cfg ", "debian-installer=en_US auto locale=en_US kbd-chooser/method=us ", "hostname={{ .Name }} ", "fb=false debconf/frontend=noninteractive ", "keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ", "keyboard-configuration/variant=USA console-setup/ask_detect=false ", "grub-installer/bootdev=/dev/sda ", "initrd=/install/initrd.gz -- <enter>"]
  disk_type_id        = "thin"
  floppy_files        = ["preseed/ubuntu.cfg"]
  guest_os_type       = "ubuntu-64"
  headless            = false
  iso_checksum        = "737ae7041212c628de5751d15c3016058b0e833fdc32e7420209b76ca3d0a535"
  iso_checksum_type   = "sha256"
  iso_url             = "http://old-releases.ubuntu.com/releases/xenial/ubuntu-16.04.2-server-amd64.iso"
  keep_registered     = true
  remote_datastore    = "${var.esxi_datastore}"
  remote_host         = "${var.esxi_host}"
  remote_password     = "${var.esxi_password}"
  remote_type         = "esx5"
  remote_username     = "${var.esxi_username}"
  shutdown_command    = "echo 'shutdown -P now' > shutdown.sh; echo 'nullgrid'|sudo -S sh 'shutdown.sh'"
  ssh_password        = "nullgrid"
  ssh_timeout         = "15m"
  ssh_username        = "nullgrid"
  tools_upload_flavor = "linux"
  vm_name             = "ubuntu-1604-base"
  vmx_data = {
    "ethernet0.addressType" = "generated"
    "ethernet0.networkName" = "VM Network"
  }
}

build {
  sources = ["source.vmware-iso.ubuntu-1604-base"]

  provisioner "shell" {
    execute_command = "echo 'nullgrid' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts         = ["scripts/open-vm-tools.sh"]
  }

}
