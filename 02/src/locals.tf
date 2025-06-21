locals {
  project     = "netology"
  vpc_network = "develop"
  web_suffix  = "vm-web"
  db_suffix   = "vm-db"
  vm_web_name = "${local.project}-${local.vpc_network}-platform-${local.web_suffix}"
  vm_db_name  = "${local.project}-${local.vpc_network}-platform-${local.db_suffix}"
}
