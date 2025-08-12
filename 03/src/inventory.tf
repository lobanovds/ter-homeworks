locals {
  instances = {
    webservers = yandex_compute_instance.web,
    databases  = yandex_compute_instance.db,
    storages   = yandex_compute_instance.storage[*]
  }
}

resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      instances = local.instances,
      bastion   = var.external_access_bastion ? yandex_compute_instance.bastion[0] : null
    }
  )
  filename = "${abspath(path.module)}/hosts.ini"
}

resource "local_file" "hosts_yaml" {
  content = templatefile("${path.module}/hosts_yaml.tftpl",
    {
      instances = local.instances,
      bastion   = var.external_access_bastion ? yandex_compute_instance.bastion[0] : null
    }
  )
  filename = "${abspath(path.module)}/hosts.yaml"
}
