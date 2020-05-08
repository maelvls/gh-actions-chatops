terraform {
  backend "gcs" {
    bucket = "tfstate-gh"
  }
}

provider "google" {
  project = "tfstate750"
  region  = "us-central1"
}

# IMPORTANT: the CI's service account "tfstate-sa" must be able to access
# to gs://tfstate-gh, but since it is also used to create the
# gs://my-static-site bucket, we also have to give it write privileges
# using:
#
#    gcloud projects add-iam-policy-binding tfstate750 \
#        --role=roles/storage.admin \
#        --member=serviceAccount:tfstate-sa@tfstate750.iam.gserviceaccount.com
#
# I wished I could also create that binding here in the terraform config
# file, but there seems to be an egg-and-chicken issue here...

resource "google_storage_bucket" "static_site" {
  name          = "my-static-site"
  location      = "EU"
  force_destroy = true

  bucket_policy_only = false

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# See the result at: https://storage.googleapis.com/my-static-site/index.html
resource "google_storage_bucket_object" "index_html" {
  bucket  = google_storage_bucket.static_site.name
  name    = "index.html"
  content = "😅"
}
