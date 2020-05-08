terraform {
  backend "gcs" {
    bucket = "tfstate-gh"
  }
}

provider "google" {
  project = "tfstate750"
  region  = "us-central1"
}

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
  content = "My super content 😅"
}
