data "yandex_compute_image" "ubuntu" {
  family = var.yandex_compute_image
}


resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count       = 2
  name = "${local.vm_web_name}-${count.index+1}"
  # hostname    = "${local.vm_web_name}-${count.index+1}"
  platform_id = var.vms_resources.default_minimal.platform_id
  zone        = var.vms_resources.default_minimal.zone
  resources {
    cores         = var.vms_resources.default_minimal.cores
    memory        = var.vms_resources.default_minimal.memory
    core_fraction = var.vms_resources.default_minimal.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.default_minimal.disk_type
      size     = var.vms_resources.default_minimal.disk_size
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources.default_minimal.is_preemtable
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.web[count.index].id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = local.metadata

}