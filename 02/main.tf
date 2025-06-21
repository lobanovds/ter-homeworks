resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop-d" {
  name           = var.vpc_name
  zone           = var.zone_yandex_ru_central_d
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}

resource "yandex_compute_instance" "platform-d" {
  name        = var.vm_web_yandex_compute_instance
  hostname    = var.vm_web_yandex_compute_instance
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = var.vm_web_boot_disk_type
      size = var.vm_web_boot_disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_is_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-d.id
    nat       = var.vm_web_is_nat
  }

  metadata = {
    serial-port-enable = var.vm_web_is_serial_port_enabled
    ssh-keys           = "${var.vm_web_image_user}:${var.vms_ssh_root_key}"
  }

}
