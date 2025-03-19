variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vm_template" {}
variable "vsphere_datacenter" {}
variable "vsphere_cluster" {}
variable "vsphere_datastore" {}
variable "vm_name" {
  default = "nginx-server"
}
variable "vm_ipv4_address" {
  default = "192.168.154.138"
}
variable "vm_ipv4_gateway" {
  default = "192.168.154.1"
}
variable "vm_network" {
  default = "VM Network"
}