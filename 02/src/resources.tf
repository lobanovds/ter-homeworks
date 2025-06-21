variable "vms_resources" {
  default = {
    web = {
      zone          = "ru-central1-d"
      cores         = 2,
      memory        = 1,
      core_fraction = 20,
      disk_size     = 5,
      disk_type     = "network-hdd",
      is_nat        = true,
      platform_id   = "standard-v3",
      cidr          = ["10.0.1.0/24"],
      is_preemtable = true,
    },
    db = {
      zone          = "ru-central1-b",
      cores         = 2,
      memory        = 2,
      core_fraction = 20,
      disk_size     = 5,
      disk_type     = "network-hdd",
      is_nat        = true,
      platform_id   = "standard-v3",
      cidr          = ["10.0.2.0/24"],
      is_preemtable = true,
    }
  }
}