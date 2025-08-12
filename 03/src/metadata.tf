locals {
  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file(pathexpand("~/.ssh/yc_ed25519.pub"))}"
  }
}