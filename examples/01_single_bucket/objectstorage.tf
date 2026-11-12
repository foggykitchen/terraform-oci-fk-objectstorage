module "objectstorage" {
  source = "../.."

  compartment_ocid = var.compartment_ocid
  name             = "fk-obj-demo-01"

  buckets = {
    artifacts = {}
  }
}
