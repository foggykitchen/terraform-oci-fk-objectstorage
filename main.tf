data "oci_objectstorage_namespace" "this" {
  compartment_id = var.compartment_ocid
}

locals {
  namespace = coalesce(var.namespace, data.oci_objectstorage_namespace.this.namespace)
}

resource "oci_objectstorage_bucket" "this" {
  for_each = var.buckets

  compartment_id = var.compartment_ocid
  namespace      = local.namespace
  name           = coalesce(try(each.value.name, null), "${var.name}-${each.key}")

  access_type           = try(each.value.access_type, "NoPublicAccess")
  auto_tiering          = try(each.value.auto_tiering, "Disabled")
  kms_key_id            = coalesce(try(each.value.kms_key_id, null), var.kms_key_id)
  metadata              = try(each.value.metadata, {})
  object_events_enabled = try(each.value.object_events_enabled, false)
  storage_tier          = try(each.value.storage_tier, "Standard")
  versioning            = try(each.value.versioning, "Disabled")

  defined_tags  = merge(var.defined_tags, try(each.value.defined_tags, {}))
  freeform_tags = merge(var.freeform_tags, try(each.value.freeform_tags, {}))
}
