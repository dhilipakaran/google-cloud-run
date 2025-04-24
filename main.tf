provider "google" {
  project = ""
  region  = ""
}
resource "google_cloud_run_service" "my_app" {
  name     = "my_application"
  region   = ""

  template {
    spec {
      containers {
        image = ""
        ports {
          container_port =
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

resource "google_cloud_run_service_iam_member" "invoker" {
  region   = google_cloud_run_service.my_app.location
  service  = google_cloud_run_service.my_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
