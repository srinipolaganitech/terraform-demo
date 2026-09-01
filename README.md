# GCP Storage Bucket with Terraform Cloud Backend

A minimal Terraform configuration that provisions a Google Cloud Storage bucket and wires the project up to a Terraform Cloud (remote) backend and workspace for state management. It's a compact reference for GCP resource provisioning combined with a Terraform Cloud-based remote-state workflow.

## How this differs from my other infra/DevOps repos

This is the GCP half of a two-cloud Terraform pairing. It provisions a GCS bucket and points at a Terraform Cloud backend/workspace for remote state, while [`aws-terraform-demo`](../aws-terraform-demo) provisions the equivalent object-storage resource on AWS (an S3 bucket) with local state and no backend configured. Together they show the same basic "provision one storage bucket" pattern implemented across two clouds and two different state-management approaches.

## Tech Stack

- Terraform
- Google Cloud provider (Cloud Storage)
- Terraform Cloud (remote backend / workspace)

## Architecture

Two files make up the configuration:

- `backend.tf` — a `terraform` block pointing at a Terraform Cloud organization (`cloudaifocus`) and workspace (`ws-terraform-demo`) for remote state.
- `main.tf` — a single `google_storage_bucket.gcs-bucket-1` resource: bucket name `tf-demo-bkt-002`, `location = "US"`, `force_destroy = true`, and `public_access_prevention = "enforced"`.

There is no explicit `provider "google" {}` or `required_providers` block — the Google provider is resolved implicitly, which is worth pinning explicitly before reuse.

## Getting Started

**Prerequisites**

- [Terraform](https://www.terraform.io/downloads) v1.0+
- A GCP project and credentials with Storage Admin permissions
- Either a Terraform Cloud account with access to the `cloudaifocus` org / `ws-terraform-demo` workspace, or a willingness to swap out the backend for local state (see Cleanup Notes)

**Authenticate to GCP**

```bash
gcloud auth login
gcloud config set project <YOUR_PROJECT_ID>
# or, for a service account:
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/sa-key.json"
```

**Run it**

```bash
terraform init
terraform plan
terraform apply
```

**Tear down**

```bash
terraform destroy
```

**Customize before reusing:**
- Change `project` in `main.tf` from `argon-gear-478416-a0` to your own GCP project ID.
- Change the bucket `name` — GCS bucket names are globally unique.
- Either point the backend at your own Terraform Cloud org/workspace, or replace it with a local/GCS backend (see Cleanup Notes — the backend block as written likely won't init correctly).

## Project Structure

```
terraform-demo/
├── backend.tf   # Terraform Cloud backend/workspace config
├── main.tf      # single GCS bucket resource
└── README.md
```
