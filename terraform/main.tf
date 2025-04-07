

resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repo_name
  format        = "DOCKER"
}


resource "google_cloud_run_service" "webapp" {
  name     = "webapp"
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_name}/webapp"
        ports {
          container_port = 8080
        }
        env {
          name  = "ASPNETCORE_URLS"
          value = "http://+:8080"
        }
		env {
          name  = "ASPNETCORE_ENVIRONMENT"
          value = "Development"
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


resource "google_cloud_run_service_iam_policy" "public_access" {
  location = google_cloud_run_service.webapp.location
  service  = google_cloud_run_service.webapp.name

  policy_data = jsonencode({
    bindings = [{
      role    = "roles/run.invoker"
      members = ["allUsers"]
    }]
  })
}