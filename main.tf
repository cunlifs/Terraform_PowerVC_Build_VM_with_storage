################################################################
# Module to deploy via IBM PowerVC
# Author: Stu Cunliffe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# Copyright IBM Corp. 2017.
#
################################################################

provider "openstack" {
    user_name   = var.openstack_user_name
    password    = var.openstack_password
    tenant_name = var.openstack_default_project_name
    domain_name = var.openstack_domain_name
    auth_url    = var.openstack_auth_url
    insecure    = true
}

resource "random_id" "rand" {
    byte_length = 2
}

resource "openstack_compute_keypair_v2" "vm-key-pair" {
    name       = "terraform-vm-key-pair-${random_id.rand.hex}"
    public_key = file("${var.public_key_file}")
}

resource "openstack_compute_instance_v2" "smc-vm" {
    count     = 1
    name      = format("sc-sles-vm-${random_id.rand.hex}-%02d", count.index+1)
    image_id  = var.openstack_image_id_SLES15_SP2
    flavor_id = var.openstack_flavor_id_node_small
    key_pair  = openstack_compute_keypair_v2.vm-key-pair.name

    network {
        uuid = var.openstack_network_id
        name = var.openstack_network_name
    }
    provisioner "remote-exec" {
        connection {
            type        = "ssh"
            user        = var.sles_username
            host        = self.access_ip_v4
            private_key = local.private_key
            agent       = var.ssh_agent
            timeout     = "${var.connection_timeout}m"
        }

        on_failure  = continue
        inline = [
             "cat /etc/hosts"
        ]
    }
#    user_data = file("bootstrap_icp_worker.sh")
}
