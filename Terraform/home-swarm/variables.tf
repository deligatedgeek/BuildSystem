#
#  See https://www.terraform.io/intro/getting-started/variables.html for more details.
#

#  Change these defaults to fit your needs!

variable "esxi_hostname" {
  default = "esxi"
}

variable "esxi_hostport" {
  default = "22"
}

variable "esxi_hostssl" {
  default = "443"
}

variable "esxi_username" {
  default = "root"
}

variable "esxi_password" { # Unspecified will prompt
}

variable "docker_nodes" {
  description = "Docker nodes"
  type	      = list(string)
  default     = ["home-esx-swarm-01", "home-esx-swarm-02", "home-esx-swarm-03"]
}
