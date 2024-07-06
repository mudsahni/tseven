provider "google" {
  project     = var.project_id
  region      = var.region
}

resource "google_cloud_run_service" "tseven" {
  name     = "tseven"
  location = var.region

  template {
    spec {
      containers {
        image = var.image_name
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
}

resource "google_project_service" "run_api" {
  project = var.project_id
  service = "run.googleapis.com"
}

resource "google_project_service" "iam_api" {
  project = var.project_id
  service = "iam.googleapis.com"
}
resource "google_project_iam_member" "run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:service-${data.google_project.project.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

data "google_project" "project" {
  project_id = var.project_id
}

output "cloud_run_url" {
  value = google_cloud_run_service.tseven.status[0].url
}
