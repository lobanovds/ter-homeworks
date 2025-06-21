
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

###VM vars

variable "vm_db_yandex_compute_instance" {
  type        = string
  default     = "netology-develop-platform-web-db"
  description = "имя и хост виртуалки"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "Число ядер"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Объём ОЗУ в ГБ(целое число)"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "Минимальный гарантированный процент нагрузки процессора"
}

variable "vm_db_boot_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "https://yandex.cloud/ru/docs/compute/concepts/disk"
}

variable "vm_db_boot_disk_size" {
  type        = number
  default     = 5
  description = "размер диска"
}

variable "vm_db_is_preemptible" {
  type        = bool
  default     = true
  description = "Прерываемая ВМ"
}

variable "vm_db_is_nat" {
  type        = bool
  default     = true
  description = "Нужен ли внешний IP"
}

variable "vm_db_is_serial_port_enabled" {
  type        = number
  default     = 1
  description = "Нужен ли внешний IP"
}

variable "vm_db_image_user" {
  type        = string
  default     = "ubuntu"
  description = "Нужен ли внешний IP"
}


variable "vm_db_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}
