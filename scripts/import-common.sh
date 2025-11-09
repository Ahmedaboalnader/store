#!/usr/bin/env bash
set -euo pipefail

# import-common.sh
# Usage: ./scripts/import-common.sh <PROJECT_ID> [REGION]
# This imports existing Google Service Account and IAM binding into the
# terraform state for terraform/services/common.

PROJECT_ID="${1:-}"
REGION="${2:-us-central1}"

if [ -z "$PROJECT_ID" ]; then
  echo "Usage: $0 <PROJECT_ID> [REGION]" >&2
  exit 2
fi

echo "Importing common resources for project: $PROJECT_ID (region: $REGION)"

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
COMMON_DIR="$ROOT_DIR/terraform/services/common"
SERVICES_DIR="$ROOT_DIR/terraform/services"

if [ ! -d "$COMMON_DIR" ]; then
  echo "ERROR: expected directory $COMMON_DIR to exist" >&2
  exit 1
fi

if [ ! -d "$SERVICES_DIR" ]; then
  echo "ERROR: expected directory $SERVICES_DIR to exist" >&2
  exit 1
fi

# Initialize terraform in the services root so the backend configuration
# (terraformbackend.tf) is included. If we init inside 'common' the parent
# backend file won't be read and terraform will fall back to local state.
pushd "$SERVICES_DIR" >/dev/null

echo "Initializing terraform in $SERVICES_DIR"
terraform init -input=false -upgrade

# Ensure the correct Terraform Cloud workspace is selected (if configured)
# Read workspace name from terraformbackend.tf if present, otherwise fall back
# to 'default'. This ensures Terraform has a remote state available for imports.
TF_BACKEND_FILE="$SERVICES_DIR/terraformbackend.tf"
TF_WORKSPACE_NAME="default"
if [ -f "$TF_BACKEND_FILE" ]; then
  # extract name = "..." value (simple grep -P, fall back if not supported)
  detected_name=$(grep -oP 'workspaces\s*\{[^}]*name\s*=\s*"\K[^"]+' "$TF_BACKEND_FILE" 2>/dev/null || true)
  if [ -z "$detected_name" ]; then
    detected_name=$(grep -oE 'name\s*=\s*"[^"]+"' "$TF_BACKEND_FILE" | sed -E 's/.*"([^"]+)".*/\1/' || true)
  fi
  if [ -n "$detected_name" ]; then
    TF_WORKSPACE_NAME="$detected_name"
  fi
fi

echo "Selecting Terraform workspace: $TF_WORKSPACE_NAME"
if terraform workspace select "$TF_WORKSPACE_NAME" >/dev/null 2>&1; then
  echo "Workspace '$TF_WORKSPACE_NAME' selected"
else
  echo "Workspace '$TF_WORKSPACE_NAME' not found, creating it"
  terraform workspace new "$TF_WORKSPACE_NAME" || true
fi

# Import service account
SA_ID="projects/${PROJECT_ID}/serviceAccounts/cloud-run-service-account@${PROJECT_ID}.iam.gserviceaccount.com"
echo "Importing google_service_account.cloud_run_sa as $SA_ID"
if terraform state list | grep -q '^google_service_account.cloud_run_sa$'; then
  echo "google_service_account.cloud_run_sa already in state, skipping import"
else
  terraform import "google_service_account.cloud_run_sa" "$SA_ID"
fi

# Import project IAM binding for cloudsql client role
IAM_ID="${PROJECT_ID}/roles/cloudsql.client"
echo "Importing google_project_iam_binding.cloudsql_access as $IAM_ID"
if terraform state list | grep -q '^google_project_iam_binding.cloudsql_access$'; then
  echo "google_project_iam_binding.cloudsql_access already in state, skipping import"
else
  terraform import "google_project_iam_binding.cloudsql_access" "$IAM_ID"
fi

echo "Done. Run 'terraform plan' to verify." 

popd >/dev/null
