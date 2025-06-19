terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }
  required_version = ">=1.8.4"
}

provider "docker" {}

resource "docker_buildx_builder" "remote_docker_builder" {
  name = "hw_context"
  use = true
  connection {
    host = "ssh://debian@51.250.47.241"
  }
  remote {
    key = "C:\\Users\\loban\\.ssh\\id_rsa"
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "hello_world"

  ports {
    internal = 80
    external = 9090
  }
}
