# README 

This README explains the purpose and usage of the `test.tf` Terraform configuration located in the project root.

**File:** `main.tf`

## Purpose

The Terraform configuration creates a Google Cloud Storage (GCS) bucket and configures a Terraform Cloud/Enterprise backend workspace. It's intended as a simple demo of provisioning a GCS bucket and using a remote Terraform backend/workspace.

## What it creates

- A `google_storage_bucket` resource named `gcs-bucket-1` with:
  - `name`: `tf-demo-bkt-002`
  - `location`: `US`
  - `force_destroy`: `true` (allows deleting a non-empty bucket)
  - `project`: `argon-gear-478416-a0` (change to your GCP project ID)
  - `public_access_prevention`: `enforced` (prevents public access)

- A `terraform` block that configures a Terraform Cloud/Enterprise backend:
  - `organization`: `cloudaifocus`
  - `workspaces.name`: `ws-terraform-demo`

## Prerequisites

- Terraform (recommended version 1.0+). Install from https://www.terraform.io/downloads
- A Google Cloud Platform (GCP) project and credentials with permission to create storage buckets.
- If using Terraform Cloud/Enterprise as the backend, an account and an organization named `cloudaifocus`, and a workspace named `ws-terraform-demo`. Alternatively, modify or remove the backend configuration to use a local backend.

## Recommended Setup

1. Install and authenticate the Google Cloud SDK (or provide credentials via environment variables):

```bash
# Install gcloud following GCP docs, then authenticate:
gcloud auth login
# Set project (if needed):
gcloud config set project <YOUR_PROJECT_ID>
```

2. Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to a service account JSON key that has permissions to create storage buckets (Storage Admin role):

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/sa-key.json"
```

3. (Optional) If you want to use Terraform Cloud backend, ensure your Terraform Cloud environment has the organization `cloudaifocus` and a workspace `ws-terraform-demo`. If you do not use Terraform Cloud, remove or replace the `terraform { backend "terraform" { ... } }` block.

## Common Commands

From the directory containing `test.tf`:

```bash
# Initialize Terraform (installs providers, configures backend)
terraform init

# See planned actions
terraform plan

# Apply changes (create bucket)
terraform apply

# To destroy the created resources
terraform destroy
```

Notes:
- If the backend is configured for Terraform Cloud, `terraform init` may prompt for login to Terraform Cloud or require a Terraform Cloud API token.
- If you see errors about provider configuration, ensure you have a `provider "google" {}` block or use required_providers in a separate file. The current `test.tf` assumes the Google provider is available from your Terraform configuration.

## Customization

- Change `project = "argon-gear-478416-a0"` to your GCP project ID.
- Change the bucket `name` to a globally unique name (GCS bucket names are global).
- Remove `force_destroy = true` if you do not want Terraform to delete non-empty buckets automatically.
- Remove or modify the `terraform { backend "terraform" { ... } }` block if you want to use a different backend (local, GCS backend, etc.).

## Security and Cleanup

- Avoid committing your service account keys to source control. Use environment variables or secrets management.
- After testing, run `terraform destroy` to remove created resources and avoid unexpected costs.

## Troubleshooting

- Bucket name conflicts: GCS bucket names are global; pick a unique name.
- Backend errors: If Terraform Cloud backend is unreachable or misconfigured, you can comment out or remove the `terraform { backend ... }` block and use a local state file for testing.
- Permissions errors: Ensure the credentials in `GOOGLE_APPLICATION_CREDENTIALS` have `roles/storage.admin` or equivalent.

If you'd like, I can:
- Add a `provider "google" {}` configuration with a recommended `required_providers` block.
- Replace the Terraform Cloud backend with a local or GCS backend example.
- Add a `variables.tf` file to parameterize `project`, `bucket_name`, and `location`.

Tell me which option you'd prefer and I'll update the repo accordingly.
