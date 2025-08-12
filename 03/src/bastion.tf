variable "external_access_bastion" {
  type    = bool
  default = false
}


resource "yandex_compute_instance" "bastion" {
  count = var.external_access_bastion ? 1 : 0

  connection {
    type    = "ssh"
    user    = "ubuntu"
    host    = self.network_interface.0.nat_ip_address
    private_key = file("~/.ssh/yc_ed25519")
    timeout = "120s"
  }

  name        = "bastion"
  hostname    = "bastion"
  platform_id = "standard-v1"

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

  metadata = local.metadata

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}
