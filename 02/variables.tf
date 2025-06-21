###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "zone_yandex_ru_central_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Образ, из которого мы будем собирать виртуалку"
}

variable "vm_web_yandex_compute_instance" {
  type        = string
  default     = "netology-develop-platform-web-d"
  description = "имя и хост виртуалки"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Платформа"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Число ядер"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Объём ОЗУ в ГБ(целое число)"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "Минимальный гарантированный процент нагрузки процессора"
}

variable "vm_web_boot_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "https://yandex.cloud/ru/docs/compute/concepts/disk"
}

variable "vm_web_boot_disk_size" {
  type        = number
  default     = 5
  description = "размер диска"
}

variable "vm_web_is_preemptible" {
  type        = bool
  default     = true
  description = "Прерываемая ВМ"
}

variable "vm_web_is_nat" {
  type        = bool
  default     = true
  description = "Нужен ли внешний IP"
}

variable "vm_web_is_serial_port_enabled" {
  type        = number
  default     = 1
  description = "Нужен ли внешний IP"
}

variable "vm_web_image_user" {
  type        = string
  default     = "ubuntu"
  description = "Нужен ли внешний IP"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}


variable "yc_public_key" {
  type        = string
  default     = "<your_yc_public_key>"
  description = "https://yandex.cloud/ru/docs/iam/operations/iam-token/create-for-sa#api_1"
}


