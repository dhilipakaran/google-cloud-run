provider "google" {
  project = "galvanic-portal-456405-a2"
  region  = "us-central1"
}

resource "google_cloud_run_service" "my-app" {
  name     = "my-app"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "docker.io/dhilipakaran/testing:v1"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.my-app.location
  service  = google_cloud_run_service.my-app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "cloud_run_url" {
  value = google_cloud_run_service.my-app.status[0].url
}
