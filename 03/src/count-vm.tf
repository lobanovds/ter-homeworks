resource "yandex_vpc_subnet" "web" {
  count      = 2
  name       = "${var.vpc_name}-${var.default_zone}-web-${count.index + 1}"
  zone       = var.default_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1${count.index + 1 }.0/24"]
}

data "yandex_compute_image" "ubuntu" {
  family = var.yandex_compute_image
}


resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count       = 2
  name        = "${local.vm_web_name}-${count.index+1}"
  hostname    = "${local.vm_web_name}-${count.index+1}"
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
  dynamic "secondary_disk" {
    iterator = inner
    for_each = count.index == 0 ? flatten([yandex_compute_disk.automatic, yandex_compute_disk.storage]) : []
    content {
      device_name = inner.value.name
      disk_id     = inner.value.id
      mode        = "READ_WRITE"
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