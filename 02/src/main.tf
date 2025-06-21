resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "develop_d" {
  name           = "develop-ru-central1-d"
  zone           = var.zone_yandex_ru_central_d
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_default_cidr
}


resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-ru-central1-b"
  zone           = var.zone_yandex_ru_central_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}



resource "yandex_compute_instance" "platform-db" {
  name        = var.vm_db_yandex_compute_instance
  hostname    = var.vm_db_yandex_compute_instance
  platform_id = var.vm_db_platform_id
  zone           = var.zone_yandex_ru_central_b

  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_db_boot_disk_type
      size     = var.vm_db_boot_disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_is_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_db_is_nat
  }

  metadata = {
    serial-port-enable = var.vm_db_is_serial_port_enabled
    ssh-keys           = "${var.vm_db_image_user}:${var.vm_db_ssh_root_key}"
  }

}



resource "yandex_compute_instance" "platform-d" {
  name        = var.vm_web_yandex_compute_instance
  hostname    = var.vm_web_yandex_compute_instance
  platform_id = var.vm_web_platform_id
  zone           = var.zone_yandex_ru_central_d
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_web_boot_disk_type
      size     = var.vm_web_boot_disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_is_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_d.id
    nat       = var.vm_web_is_nat
  }

  metadata = {
    serial-port-enable = var.vm_web_is_serial_port_enabled
    ssh-keys           = "${var.vm_web_image_user}:${var.vm_web_ssh_root_key}"
  }

}
