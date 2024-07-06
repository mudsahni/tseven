variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The GCP region"
  default     = "us-central1"
}

variable "image_name" {
  description = "The Docker image name"
}
