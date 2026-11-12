mock_provider "oci" {
  mock_data "oci_objectstorage_namespace" {
    defaults = { namespace = "mock-namespace" }
  }
}

variables {
  tenancy_ocid     = "mock-tenancy"
  user_ocid        = "mock-user"
  fingerprint      = "mock-fingerprint"
  private_key_path = "/not-used-by-mock"
  region           = "eu-frankfurt-1"
  compartment_ocid = "mock-compartment"
}

run "example_plan" {
  command = plan
  assert {
    condition     = length(output.bucket_names) == 2 && output.namespace == "mock-namespace"
    error_message = "The example must plan the documented number of buckets in the discovered namespace."
  }
}
