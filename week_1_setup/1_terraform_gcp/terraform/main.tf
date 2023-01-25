terraform {
  backend "local" {}
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_region
#   credentials = file(var.gcp_credentials_path)
}

resource "google_storage_bucket" "data-lake-bucket" {
  name     = "de-zoomcamp-2023_${var.gcp_project_id}"
  location = var.gcp_region

  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 # days
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.bigquery_dataset
  project    = var.gcp_project_id
  location   = var.gcp_region
}