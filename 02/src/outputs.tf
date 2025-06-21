output "test" {

  value = [
    {
      name        = yandex_compute_instance.platform-d.name,
      external_ip = yandex_compute_instance.platform-d.network_interface[0].nat_ip_address,
      fqdn        = yandex_compute_instance.platform-d.fqdn
    },
    {
      name        = yandex_compute_instance.platform-db.name,
      external_ip = yandex_compute_instance.platform-db.network_interface[0].nat_ip_address,
      fqdn        = yandex_compute_instance.platform-db.fqdn
    },
  ]
}