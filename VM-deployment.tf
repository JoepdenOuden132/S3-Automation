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
  password       = "jouw-wachtwoord"
  vsphere_server = "vcenter.netlab.fontysict.nl"
  allow_unverified_ssl = true
}


resource "vsphere_virtual_machine" "nginx_vm" {
  name             = "nginx-server"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 20
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "nginx-server"
        domain    = "example.com"
      }

      network_interface {
        ipv4_address = "192.168.154.138"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.154.1"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "student"
      password    = "student"
      host        = "192.168.154.138"
    }
  }
}
