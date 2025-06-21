resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop_d" {
  name           = "${var.vpc_name}-${var.zone_yandex_ru_central_d}"
  zone           = var.zone_yandex_ru_central_d
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_resources.web.cidr
}


resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-${var.zone_yandex_ru_central_b}"
  zone           = var.zone_yandex_ru_central_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_resources.db.cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.yandex_compute_image
}



resource "yandex_compute_instance" "platform-db" {
  name        = local.vm_db_name
  hostname    = local.vm_db_name
  platform_id = var.vms_resources.db.platform_id
  zone        = var.vms_resources.db.zone

  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.db.disk_type
      size     = var.vms_resources.db.disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.db.is_preemtable
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vms_resources.db.is_nat
  }

  metadata = local.metadata

}



resource "yandex_compute_instance" "platform-d" {
  name        = local.vm_web_name
  hostname    = local.vm_web_name
  platform_id = var.vms_resources.web.platform_id
  zone        = var.vms_resources.web.zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.web.disk_type
      size     = var.vms_resources.web.disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.is_preemtable
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_d.id
    nat       = var.vms_resources.web.is_nat
  }

  metadata = local.metadata

}
