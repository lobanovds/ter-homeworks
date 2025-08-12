resource "yandex_vpc_subnet" "db" {
  count      = 2
  name       = "${var.vpc_name}-${var.default_zone}-db-${count.index + 1}"
  zone       = var.default_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2${count.index + 1 }.0/24"]
}

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
    # security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.metadata

}