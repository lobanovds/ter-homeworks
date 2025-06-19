terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=1.8.4"
}

provider "docker" {
    host = "ssh://debian@51.250.47.241"
    ssh_opts = ["-i", "./id_rsa"]
}


resource "docker_image" "mysql" {
  name         = "mysql:8"
}

resource "random_password" "random_mysql_root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "random_mysql_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_container" "mysql_driver" {
  image = docker_image.mysql.image_id
  name  = "mysql"
  restart = "always"
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.random_mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.random_mysql_password.result}",
    "MYSQL_ROOT_HOST=\"%\""
  ]

  ports {
    internal = 3306
    external = 3306
  }
}