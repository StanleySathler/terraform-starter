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

# Docker image for Products API
resource "docker_image" "products-api" {
  name = "terraform-starter-products-api"
  build {
    context    = "../products-api"   # Build context
    dockerfile = "docker/Dockerfile" # Path to Dockerfile - relative to build context
  }

  # Trigger a rebuild whenever source files change
  # triggers = {
  #   dir_sha1 = sha1(join("", [for f in fileset(path.module, "src/*") : filesha1(f)]))
  # }
}

resource "docker_container" "products-api" {
  image = docker_image.products-api.image_id
  name  = "terraform-starter-products-api"

  ports {
    internal = 3001
    external = 3001
  }
}