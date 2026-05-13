variable "compartment_ocid" {
  description = "Compartment OCID where the Object Storage buckets will be created."
  type        = string
}

variable "name" {
  description = "Base name used to derive bucket names when buckets[*].name is not provided."
  type        = string
}

variable "namespace" {
  description = "Optional Object Storage namespace override. By default the namespace is discovered automatically."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "Optional default KMS key OCID used for bucket encryption when not overridden per bucket."
  type        = string
  default     = null
}

variable "defined_tags" {
  description = "Defined tags applied to buckets created by the module."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to buckets created by the module."
  type        = map(string)
  default     = {}
}

variable "buckets" {
  description = "Map of Object Storage buckets to create."
  type = map(object({
    name                  = optional(string)
    access_type           = optional(string, "NoPublicAccess")
    auto_tiering          = optional(string, "Disabled")
    kms_key_id            = optional(string)
    metadata              = optional(map(string), {})
    object_events_enabled = optional(bool, false)
    storage_tier          = optional(string, "Standard")
    versioning            = optional(string, "Disabled")
    defined_tags          = optional(map(string), {})
    freeform_tags         = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for bucket in values(var.buckets) : contains(["NoPublicAccess", "ObjectRead", "ObjectReadWithoutList"], try(bucket.access_type, "NoPublicAccess"))
    ])
    error_message = "Each bucket.access_type must be one of NoPublicAccess, ObjectRead, or ObjectReadWithoutList."
  }

  validation {
    condition = alltrue([
      for bucket in values(var.buckets) : contains(["Standard", "Archive"], try(bucket.storage_tier, "Standard"))
    ])
    error_message = "Each bucket.storage_tier must be either Standard or Archive."
  }

  validation {
    condition = alltrue([
      for bucket in values(var.buckets) : contains(["Enabled", "Disabled"], try(bucket.versioning, "Disabled"))
    ])
    error_message = "Each bucket.versioning must be either Enabled or Disabled."
  }
}
