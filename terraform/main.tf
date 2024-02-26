# General config for Terraform
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" # Provider source
      version = "~> 3.0.1"           # Provider version, omit to install latest
    }
  }
}

# Config for the provider
provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = 8080
  }
}