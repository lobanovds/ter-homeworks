resource "yandex_vpc_subnet" "web" {
  count      = 2
  name       = "${var.vpc_name}-${var.default_zone}-web-${count.index + 1}"
  zone       = var.default_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1${count.index + 1 }.0/24"]
}

resource "yandex_vpc_subnet" "db" {
  count      = 2
  name       = "${var.vpc_name}-${var.default_zone}-db-${count.index + 1}"
  zone       = var.default_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2${count.index + 1 }.0/24"]
}

resource "yandex_vpc_subnet" "storage" {
  name       = "${var.vpc_name}-${var.default_zone}-storage"
  zone       = var.default_zone
  network_id = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.30.0/24"]
}
