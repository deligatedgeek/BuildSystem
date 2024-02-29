#platform=x86, AMD64, or Intel EM64T
#version=RHEL8
# License agreement
eula --agreed
# Reboot after installation
reboot
# Use text mode install
text
# Installation logging level
logging --level=info
repo --name="Copr-cloud-init" --baseurl=https://download.copr.fedorainfracloud.org/results/@cloud-init/cloud-init-dev/epel-8-$basearch/ --noverifyssl --install
#repo --name="AppStream" --baseurl=http://192.168.1.5/repo/Linux/Rocky-8.5-x86_64/AppStream

%packages
@base
@core
cloud-init
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
-pcmcmautmls
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rdma
-rfkill
-rsync
-rt61pci-firmware
-rt73usb-firmware
-strace
-usbutils
-wget
-xorg-x11
-ypbinda
-zd1211-firmware

%end

# Keyboard layouts
keyboard --vckeymap=uk --xlayouts='gb'
# System language
lang en_GB.UTF-8

# Firewall configuration
firewall --enabled --service=ssh,ssh
# Network information
network  --bootproto=dhcp --device=ens33 --noipv6 --activate

# Use network installation
url --url="https://mirror.cs.pitt.edu//centos-vault/8.5/BaseOS/x86_64/os/"

# System authorization information
auth --useshadow --passalgo=sha512
# SELinux configuration
selinux --enforcing

# Do not configure the X Window System
skipx
# System services
services --enabled="NetworkManager,sshd"

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
timezone Europe/London --isUtc

# Root password
rootpw --iscrypted $6$lgFo6lMqJgfON0ge$dkBDrCZGvnfwvq6EpVl6gy9079eGRro3Nc3tzay.Sd1iw6YPNr7svepqfBUdSOlu41cuZeFWQH2PLTjbU6Ogt/

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%post
touch /etc/cloud/cloud-init.disabled
%end