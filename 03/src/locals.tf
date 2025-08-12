locals {
  project         = "netology"
  vpc_network     = "develop"
  web_suffix      = "web"
  db_suffix       = "db"
  storage_suffix  = "storage"
  vm_web_name     = "${local.project}-${local.vpc_network}-platform-${local.web_suffix}"
  vm_db_name      = "${local.project}-${local.vpc_network}-platform-${local.db_suffix}"
  vm_storage_name = "${local.project}-${local.vpc_network}-platform-${local.storage_suffix}"

  vpc = {
    "network_id" = "enp7i560tb28nageq0cc"
    "subnet_ids" = [
      "e9b0le401619ngf4h68n",
      "e2lbar6u8b2ftd7f5hia",
      "b0ca48coorjjq93u36pl",
      "fl8ner8rjsio6rcpcf0h",
    ]
    "subnet_zones" = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-c",
      "ru-central1-d",
    ]
  }

  new_vpc = {
    "network_id"   = local.vpc.network_id
    "subnet_ids"   = [for index, elem in local.vpc.subnet_ids : elem if index != 2]
    "subnet_zones" = [for index, elem in local.vpc.subnet_zones : elem if index != 2]
  }

  task_9_1 = [for num in range(100) : "rc${format("%02d",num)}"]

  allowed_last_digs = [for i in range(6) : tostring(i+1)]
  task_9_2          = [
    for num in range(100) : "rc${format("%02d",num)}"
    if substr(format("%02d", num), length(format("%02d", num)) - 2, 2) == "19" ||
    contains(local.allowed_last_digs, substr(format("%02d", num), length(format("%02d", num)) - 1, 1))
  ]
}

