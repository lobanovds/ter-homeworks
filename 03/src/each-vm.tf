resource "yandex_compute_instance" "db" {
  for_each    = {for index, value in var.each_vm : index => value}
  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = var.vms_resources.default_minimal.platform_id
  zone        = var.vms_resources.default_minimal.zone
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vms_resources.default_minimal.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.default_minimal.disk_type
      size     = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.default_minimal.is_preemtable
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.db[each.key].id
  }

  metadata = local.metadata

}