output "cloud_run_url" {
  description = "Deployed Cloud Run Service URL"
  value       = google_cloud_run_service.webapp.status[0].url
}