locals {
  project     = "netology"
  vpc_network = "develop"
  web_suffix  = "web"
  db_suffix = "db"
  vm_web_name = "${local.project}-${local.vpc_network}-platform-${local.web_suffix}"


}
