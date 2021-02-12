output "VM_name" {
  value = openstack_compute_instance_v2.app-vms.*.name
}

output "VM_IPs" {
    value = openstack_compute_instance_v2.app-vms.*.access_ip_v4
}
