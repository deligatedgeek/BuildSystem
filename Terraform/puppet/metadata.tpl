instance-id: ${HOSTNAME}
local-hostname: ${HOSTNAME}

network:
  version: 2
  ethernets:
    ens32:
      dhcp4: false
      addresses:
        - ${address}
      gateway4: ${gateway}
      nameservers:
        search:
          - thelabratorium.cloudns.cl
        addresses:
          - ${ns1}
          - ${ns2}