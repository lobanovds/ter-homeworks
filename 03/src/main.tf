resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


output "vms" {
  value = [
    for instance in flatten([
      yandex_compute_instance.bastion, [for k, v in yandex_compute_instance.db : v], yandex_compute_instance.web,
      yandex_compute_instance.storage
    ]) :
    { name = try(instance.name, ""), id = try(instance.id, ""), fqdn = try(instance.fqdn, "") }
  ]
}
