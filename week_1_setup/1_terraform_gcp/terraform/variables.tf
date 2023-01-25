locals {
  data_lake_bucket = "dtc-de-23_data_lake"
}

variable "gcp_project_id" {
  description = "Your GCP Project ID"
  type = string
  default = "dtc-de-373720"
}

variable "gcp_region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "europe-west6"
  type = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}

variable "bigquery_dataset" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "trips_data_all"
}