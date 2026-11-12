mock_provider "oci" {
  mock_data "oci_objectstorage_namespace" {
    defaults = { namespace = "mock-namespace" }
  }
}

variables {
  compartment_ocid = "mock-compartment"
  name             = "compatibility"
  buckets = {
    private = {}
    archive = { name = "explicit-archive", storage_tier = "Archive" }
  }
}

run "bucket_defaults_and_overrides" {
  command = plan
  assert {
    condition     = output.namespace == "mock-namespace" && output.bucket_names["private"] == "compatibility-private" && output.bucket_names["archive"] == "explicit-archive"
    error_message = "Namespace discovery and explicit/default bucket names must be preserved."
  }
  assert {
    condition     = output.buckets["private"].access_type == "NoPublicAccess" && output.buckets["archive"].storage_tier == "Archive"
    error_message = "Bucket privacy defaults and archive overrides must be preserved."
  }
}

run "namespace_override" {
  command = plan
  variables {
    namespace = "explicit-namespace"
  }
  assert {
    condition     = output.namespace == "explicit-namespace"
    error_message = "An explicit namespace must take precedence over discovery."
  }
}
