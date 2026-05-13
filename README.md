# terraform-oci-fk-objectstorage

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for deploying **Oracle Cloud Infrastructure (OCI) Object Storage** resources as a bucket-based storage layer for application artifacts, logs, and data exchange.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed to work cleanly with reusable infrastructure modules such as **`terraform-oci-fk-vcn`**, **`terraform-oci-fk-compute`**, and **`terraform-oci-fk-filestorage`**.

---

## Purpose

The goal of this module is to provide a **clean, composable, and educational reference implementation** for OCI Object Storage:

- Focused on OCI-native bucket primitives
- Suitable for private or public-read bucket patterns
- Designed for hands-on learning, module composition, and multicloud comparisons

This is **not** a full storage landing zone. It is a **learning-first, architecture-aware module**.

---

## What the module does

The module creates:

- OCI Object Storage namespace discovery
- One or more OCI Object Storage buckets

The module intentionally does **not** create:

- VCNs or subnets
- Pre-authenticated requests
- Object lifecycle policies
- Event rules or functions
- Compute instances or application consumers

Each of those concerns belongs in its own dedicated module.

---

## Repository Structure

```bash
terraform-oci-fk-objectstorage/
├── examples/
│   ├── 01_single_bucket/
│   ├── 02_multiple_buckets/
│   └── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate **incremental Object Storage patterns**, starting from a single private bucket and progressing to multiple buckets with different access behaviors.

---

## Example Usage

### Single private bucket

```hcl
module "objectstorage" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-objectstorage.git?ref=v0.1.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-obj"

  buckets = {
    artifacts = {}
  }
}
```

### Multiple buckets

```hcl
module "objectstorage" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-objectstorage.git?ref=v0.1.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-obj"

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
    }
  }
}
```

---

## Module Inputs

### Core inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `compartment_ocid` | `string` | yes | OCI compartment OCID where Object Storage buckets will be created |
| `name` | `string` | yes | Base name used to derive bucket names |
| `namespace` | `string` | no | Optional namespace override |
| `kms_key_id` | `string` | no | Optional default KMS key OCID |
| `defined_tags` | `map(string)` | no | Defined tags applied to buckets |
| `freeform_tags` | `map(string)` | no | Freeform tags applied to buckets |

### Bucket settings

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `buckets` | `map(object)` | no | Map of Object Storage buckets to create |

### `buckets` object schema

```hcl
buckets = map(object({
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
```

---

## Outputs

| Output | Description |
|------|-------------|
| `namespace` | Resolved OCI Object Storage namespace |
| `bucket_ids` | Map of bucket OCIDs keyed by bucket key |
| `bucket_names` | Map of bucket names keyed by bucket key |
| `buckets` | Computed bucket metadata keyed by bucket key |

---

## Examples Overview

| Example | Description |
|-------|-------------|
| `01_single_bucket` | Minimal private Object Storage deployment with a single bucket |
| `02_multiple_buckets` | Multiple buckets with different access and storage settings |

See [`examples/`](examples) for details.

---

## Design Philosophy

- Buckets are infrastructure, not application logic
- Public access must be explicit
- Small modules over monoliths
- Optimized for **learning, reuse, and composition**

This makes the module useful for:

- OCI object storage foundations
- artifacts and logs buckets
- shared module composition
- training material
- architecture workshops
- multicloud comparisons (Azure ↔ OCI)

---

## Related Modules & Training

- [terraform-oci-fk-vcn](https://github.com/mlinxfeld/terraform-oci-fk-vcn)
- [terraform-oci-fk-compute](https://github.com/mlinxfeld/terraform-oci-fk-compute)
- [terraform-oci-fk-filestorage](https://github.com/mlinxfeld/terraform-oci-fk-filestorage)
- [terraform-az-fk-storage](https://github.com/mlinxfeld/terraform-az-fk-storage)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com/courses-2/) - *Cloud. Code. Clarity.*
