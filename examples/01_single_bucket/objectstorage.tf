module "objectstorage" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-objectstorage.git?ref=v0.1.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-obj-demo-01"

  buckets = {
    artifacts = {}
  }
}
