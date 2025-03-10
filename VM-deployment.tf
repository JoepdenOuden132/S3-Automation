terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.0"
    }
  }
}

provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "your-password"
  vsphere_server = "your-vsphere-server"

  allow_unverified_ssl = true
}