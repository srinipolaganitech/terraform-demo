resource "google_storage_bucket" "gcs-bucket-1" {
  name          = "tf-demo-bkt-002"
  location      = "US"
  force_destroy = true
  project = "argon-gear-478416-a0"

  public_access_prevention = "enforced"

}
