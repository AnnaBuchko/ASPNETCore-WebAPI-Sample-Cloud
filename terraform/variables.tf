variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "webapp-prj-455709"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "repo_name" {
  description = "GCP  artifact registry name"
  type        = string
  default     = "webapp-repo"
}