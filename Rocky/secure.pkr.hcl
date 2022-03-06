variable "esx_password" {
  type =  string
  sensitive = true
}
variable "esx_host" {
  default = "192.168.1.201"
  type =  string
  sensitive = true
}
variable "repo_host" {
  default = "192.168.1.5"
  type =  string
}
variable "build_user" {
  default = "packer"
  type =  string
  sensitive = true
}
variable "build_password" {
  default = "packer"
  type =  string
  sensitive = true
}

