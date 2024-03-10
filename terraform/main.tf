# TODO: Split stuff into modules.
# ----------------------------------

# Configure the Google Cloud provider
provider "google" {
  credentials = file("gcp-service-account.json") # TODO: Check a safer approach, perhaps Workload Identity Federation?
  project     = "lab-terraform-starter"
  region      = "us-central1"
}

provider "google-beta" {
  credentials = file("gcp-service-account.json") # TODO: Check a safer approach, perhaps Workload Identity Federation?
  project     = "lab-terraform-starter"
  region      = "us-central1"
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
      image = "docker.io/stanleysathler/terraform-starter-products-api:1.0.0" # We can't always use `latest` - file must be changed so Terraform does a new deploy.
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

# Cloud Run for Carts API
resource "google_cloud_run_v2_service" "carts-api" {
  name     = "carts-api"
  location = "us-central1"
  
  template {
    scaling {
      max_instance_count = 1
    }

    containers {
      image = "docker.io/stanleysathler/terraform-starter-carts-api:1.0.1" # We can't always use `latest` - file must be changed so Terraform does a new deploy.
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
resource "google_cloud_run_v2_service_iam_member" "products-api" {
  location = google_cloud_run_v2_service.products-api.location
  name = google_cloud_run_v2_service.products-api.name
  role = "roles/run.invoker"
  member = "allUsers"
}

# Ensure Cloud Run for Carts API is publicly accessible
resource "google_cloud_run_v2_service_iam_member" "carts-api" {
  location = google_cloud_run_v2_service.carts-api.location
  name = google_cloud_run_v2_service.carts-api.name
  role = "roles/run.invoker"
  member = "allUsers"
}

# API Gateway
resource "google_api_gateway_api" "api" {
  provider = google-beta
  api_id = "api"
}

resource "google_api_gateway_api_config" "api" {
  provider = google-beta
  api = google_api_gateway_api.api.api_id
  api_config_id = "api-config"

  openapi_documents {
    document {
      path = "openapi-spec.yaml"
      contents = filebase64("../openapi-spec.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api" {
  provider = google-beta
  api_config = google_api_gateway_api_config.api.id
  gateway_id = "api-gateway"
}