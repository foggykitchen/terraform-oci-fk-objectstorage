output "namespace" {
  description = "Resolved OCI Object Storage namespace."
  value       = local.namespace
}

output "bucket_ids" {
  description = "Map of bucket OCIDs keyed by bucket map key."
  value       = { for key, bucket in oci_objectstorage_bucket.this : key => bucket.bucket_id }
}

output "bucket_paths" {
  description = "Map of Object Storage bucket resource paths keyed by bucket map key."
  value       = { for key, bucket in oci_objectstorage_bucket.this : key => bucket.id }
}

output "bucket_names" {
  description = "Map of bucket names keyed by bucket map key."
  value       = { for key, bucket in oci_objectstorage_bucket.this : key => bucket.name }
}

output "buckets" {
  description = "Computed bucket metadata keyed by bucket map key."
  value = {
    for key, bucket in oci_objectstorage_bucket.this : key => {
      id                    = bucket.id
      bucket_id             = bucket.bucket_id
      name                  = bucket.name
      namespace             = bucket.namespace
      access_type           = bucket.access_type
      storage_tier          = bucket.storage_tier
      versioning            = bucket.versioning
      object_events_enabled = bucket.object_events_enabled
    }
  }
}
