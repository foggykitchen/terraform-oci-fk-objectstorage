module "objectstorage" {
  source = "../.."

  compartment_ocid = var.compartment_ocid
  name             = "fk-obj-demo-02"

  buckets = {
    artifacts = {
      access_type = "ObjectRead"
      metadata = {
        purpose = "downloads"
      }
    }
    logs = {
      storage_tier = "Archive"
      versioning   = "Enabled"
      metadata = {
        purpose = "logs"
      }
    }
  }
}
