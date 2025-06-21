###cloud vars
#
#
# variable "vm_web_default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vm_web_yandex_compute_instance" {
#   type        = string
#   default     = "netology-develop-platform-web-d"
#   description = "имя и хост виртуалки"
# }

# variable "vm_web_platform_id" {
#   type        = string
#   default     = "standard-v3"
#   description = "Платформа"
# }
#
# variable "vm_web_cores" {
#   type        = number
#   default     = 2
#   description = "Число ядер"
# }
#
# variable "vm_web_memory" {
#   type        = number
#   default     = 1
#   description = "Объём ОЗУ в ГБ(целое число)"
# }
#
# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 20
#   description = "Минимальный гарантированный процент нагрузки процессора"
# }
#
# variable "vm_web_boot_disk_type" {
#   type        = string
#   default     = "network-hdd"
#   description = "https://yandex.cloud/ru/docs/compute/concepts/disk"
# }
#
# variable "vm_web_boot_disk_size" {
#   type        = number
#   default     = 5
#   description = "размер диска"
# }
#
# variable "vm_web_is_preemptible" {
#   type        = bool
#   default     = true
#   description = "Прерываемая ВМ"
# }
#
# variable "vm_web_is_nat" {
#   type        = bool
#   default     = true
#   description = "Нужен ли внешний IP"
# }
#
# variable "vm_web_is_serial_port_enabled" {
#   type        = number
#   default     = 1
#   description = "Нужен ли внешний IP"
# }
#
# variable "vm_web_image_user" {
#   type        = string
#   default     = "ubuntu"
#   description = "Нужен ли внешний IP"
# }
