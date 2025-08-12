resource "yandex_compute_disk" "automatic" {
  count = 3
  name  = "temp-disk-${count.index}"
  size  = 1
  type  = "network-hdd"
}

resource "yandex_compute_disk" "storage" {
  name = "storage"
  size = 1
  type = "network-hdd"
}