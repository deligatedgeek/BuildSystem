#cloud-config

runcmd:
    - date >/root/cloudinit.log
    - hostnamectl set-hostname ${HOSTNAME}
