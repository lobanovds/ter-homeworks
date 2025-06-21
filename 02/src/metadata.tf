###ssh vars

variable "ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}


locals {
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.ssh_root_key}"
  }
}