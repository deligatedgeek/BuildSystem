#platform=x86, AMD64, or Intel EM64T
#version=RHEL9
# License agreement
eula --agreed
# Reboot after installation
reboot
# Use text mode install
text
# Installation logging level
logging --level=info

%packages
@minimal-environment
cloud-init
cloud-utils-growpart
open-vm-tools
device-mapper-persistent-data
kexec-tools
oddjob
perl-DBD-SQLite
smartmontools
virt-what
-aic94xx-firmware
-atmel-firmware
-bfa-firmware
-eject
-ipa-client
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6050-firmware
-libertas-usb8388
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rfkill
-rsync
-rt61pci-firmware
-rt73usb-firmware
-strace
-usbutils
-wget
-xorg-x11
-zd1211-firmware

%end

# Keyboard layouts
keyboard --vckeymap=uk --xlayouts='gb'
# System language
lang en_GB.UTF-8

# Firewall configuration
firewall --enabled --service=ssh
# Network information
network  --bootproto=dhcp --noipv6 --activate

# Use network installation
url --url="http://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/"

# SELinux configuration
selinux --enforcing

# Do not configure the X Window System
skipx
# System services
services --enabled="NetworkManager,sshd,cloud-init"

ignoredisk --only-use=sda
# System bootloader configuration
bootloader --append="crashkernel=auto" --location=mbr --driveorder="sda" --boot-drive=sda
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all
# Disk partitioning information
part pv.125 --fstype="lvmpv" --size=39487
part /boot --fstype="ext4" --size=512
volgroup vg_root01 --pesize=4096 pv.125
logvol swap --fstype="swap" --grow --size=2048 --name=lv_swap --vgname=vg_root01
logvol / --fstype="ext4" --grow --size=3072 --name=lv_root --vgname=vg_root01
logvol /var --fstype="ext4" --size=4096 --name=var --vgname=vg_root01

# System timezone
timezone Europe/London --utc

# Root password
rootpw --iscrypted $6$stksXuPnECpjMbC6$wX5EdtM9lVltg2fI0aoyDCkwja/4lJwtK9cQOQWPPEfYYceCPLaOh9wSdFQ7houC1MwGKYqCe7zbfVpTl2Ykm.

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%post
# Enable root SSH login (Rocky 9 disables this by default)
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/01-permitrootlogin.conf

# Configure cloud-init to use VMware datasource (built-in since cloud-init 22.x)
cat > /etc/cloud/cloud.cfg.d/99_vmware_guest.cfg <<CLOUDEOF
datasource_list: [ VMware, None ]
CLOUDEOF

# Disable cloud-init until Terraform deploys with guestinfo metadata
touch /etc/cloud/cloud-init.disabled
%end
