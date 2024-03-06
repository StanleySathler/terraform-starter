# General config for Terraform
# terraform {
#   required_providers {
#     docker = {
#       source  = "kreuzwerker/docker" # Provider source
#       version = "~> 3.0.1"           # Provider version, omit to install latest
#     }
#   }
# }

# Config for the provider
# provider "docker" {}

# resource "docker_image" "nginx" {
#   name         = "nginx"
#   keep_locally = false
# }

# resource "docker_container" "nginx" {
#   image = docker_image.nginx.image_id
#   name  = var.container_name

#   ports {
#     internal = 80
#     external = 8080
#   }
# }


# Configure the Google Cloud provider
provider "google" {
  credentials = file("gcp-service-account.json") # TODO: Check a safer approach, perhaps Workload Identity Federation?
  project     = "lab-terraform-starter"
}

# Cloud Run for Products API
resource "google_cloud_run_v2_service" "products-api" {
  name     = "products-api"
  location = "us-central1"
  
  template {
    scaling {
      max_instance_count = 1
    }

    containers {
      image = "gcr.io/cloudrun/hello"
      resources {
        cpu_idle = true
        limits = {
          memory = "128Mi"
          cpu = "1"
        }
      }
    }
  }
}

# Ensure Cloud Run for Products API is publicly accessible
resource "google_cloud_run_v2_service_iam_member" "member" {
  location = google_cloud_run_v2_service.products-api.location
  name = google_cloud_run_v2_service.products-api.name
  role = "roles/run.invoker"
  member = "allUsers"
}