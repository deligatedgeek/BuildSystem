# BuildSystem
All the stuff to build templates and VM's across various hypervisors

# Example build command
On Linux
`PACKER_LOG=1   packer build -var-file=secure.pkrvars.hcl Rocky`

Or on MACOS
`PACKER_LOG=1   packer build -var-file=secure.pkrvars.hcl -var skip_export=true Rocky`
