output "VM_name" {
  value = openstack_compute_instance_v2.smc-vm.*.name
}

output "VM_IPs" {
    value = openstack_compute_instance_v2.smc-vm.*.access_ip_v4
}
