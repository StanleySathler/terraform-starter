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