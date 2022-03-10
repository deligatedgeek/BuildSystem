# BuildSystem
All the stuff to build templates and VM's across various hypervisors

# Local secure variables file
To build this VM you a local file to include passwords and override the default packer account name and password.

 secure.pkrvars.hcl
 
# Example build command
On systems with the VMware ovftool installed
`PACKER_LOG=1   packer build -var-file=secure.pkrvars.hcl Rocky`

For testing on systems without.
`PACKER_LOG=1   packer build -var-file=secure.pkrvars.hcl -var skip_export=true Rocky`
