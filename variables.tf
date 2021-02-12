################################################################
# Module to deploy VM via PowerVC
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

variable "openstack_user_name" {
    description = "The user name used to connect to OpenStack."
}

variable "openstack_password" {
    description = "The password for the user."
}

variable "openstack_admin_role" {
    description = "The admin role name used to control a project."
}

variable "openstack_default_project_name" {
    description = "The name of the default admin project (a.k.a. tenant) used."
}

#variable "openstack_new_project_name" {
#    description = "The name of the new user project (a.k.a. tenant) used."
#}

variable "openstack_project_user_id" {
    description = "The user name for a given project"
}

variable "openstack_domain_name" {
    description = "The domain to be used."
}

variable "openstack_auth_url" {
    description = "The endpoint URL used to connect to OpenStack."
}

variable "openstack_image_id_SLES15_SP2" {
    description = "The ID of the image to be used for SLES 15 SP2 deploy operations."
}

variable "openstack_flavor_id_node_small" {
    description = "The ID of the flavor to be used for small node deploy operations."
}

variable "openstack_flavor_id_node_medium" {
    description = "The ID of the flavor to be used for medium node deploy operations."
}

variable "openstack_flavor_id_node_large" {
    description = "The ID of the flavor to be used for large node deploy operations."
}

variable "openstack_network_id" {
    description = "The ID of the network to be used for deploy operations."
}

variable "openstack_network_name" {
    description = "The name of the network to be used for deploy operations."
}

# SSH and connection variables
variable "ssh_agent" {
    description = "Enable or disable SSH Agent. Can correct some connectivity issues. Default: false"
    default     = false
}

variable "connection_timeout" {
    description = "Timeout in minutes for SSH connections"
    default     = 10
}

variable "sles_username" {
    default = "root"
}

variable "keypair_name" {
  # Set this variable to the name of an already generated
  # keypair to use it instead of creating a new one.
  default = ""
}

variable "public_key_file" {
    description = "Path to public key file"
    # if empty, will default to ${path.cwd}/data/id_rsa.pub
    default     = ""
}

variable "private_key_file" {
    description = "Path to private key file"
    # if empty, will default to ${path.cwd}/data/id_rsa
    default     = ""
}

variable "private_key" {
    description = "Content of private SSH key"
    # if empty string will read contents of file at var.private_key_file
    default = ""
}

variable "public_key" {
    description = "Content of the Public SSH key"
    # if empty string will read contents of file at var.public_key_file
    default     = ""
}

locals {
    private_key_file    = var.private_key_file == "" ? "${path.cwd}/data/id_rsa" : var.private_key_file
    public_key_file     = var.public_key_file == "" ? "${path.cwd}/data/id_rsa.pub" : var.public_key_file
    private_key         = var.private_key == "" ? file(coalesce(local.private_key_file, "/dev/null")) : var.private_key
    public_key          = var.public_key == "" ? file(coalesce(local.public_key_file, "/dev/null")) : var.public_key
    create_keypair      = var.keypair_name == "" ? "1": "0"
}
