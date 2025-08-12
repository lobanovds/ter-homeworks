resource "yandex_compute_disk" "secondary" {
  count = 3
  name  = "secondary-disk-${count.index}"
  size  = 1
  type  = "network-hdd"
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
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
    for_each = yandex_compute_disk.secondary
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
    subnet_id = yandex_vpc_subnet.storage.id
  }

  metadata = local.metadata
}