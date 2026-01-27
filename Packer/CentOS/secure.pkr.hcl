variable "esx_password" {
  type =  string
  sensitive = true
}
variable "esx_host" {
  default = "192.168.1.20"
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
variable "skip_export" {
  default = "false"
  type = string
}

variable "remote_host" {
  type        = string
  description = "The ip or fqdn of your XenServer. This will be pulled from the env var 'PKR_VAR_remote_host'"
  sensitive   = true
  default     = null
}

variable "remote_password" {
  type        = string
  description = "The password used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_password'"
  sensitive   = true
  default     = null
}

variable "remote_username" {
  type        = string
  description = "The username used to interact with your XenServer. This will be pulled from the env var 'PKR_VAR_remote_username'"
  sensitive   = true
  default     = null

}
variable "sr_name" {
  type        = string
  default     = "vm-storage-4tb"
  description = "The name of the SR to packer will use"
}
variable "sr_iso_name" {
  type        = string
  default     = ""
  description = "The ISO-SR to packer will use"

}