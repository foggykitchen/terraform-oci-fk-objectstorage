# OCI Object Storage with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-objectstorage** module.
The examples focus on practical OCI Object Storage deployment patterns, starting with a single private bucket and then expanding to multiple buckets with different access and storage settings.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are designed to show how OCI Object Storage fits into bucket-based storage architectures.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Single Bucket** | private bucket, namespace discovery, minimal Object Storage deployment |
| 02 | **Multiple Buckets** | multiple buckets, access type differences, archive tier, versioning |

---

## How to Use

To run the single bucket example:

```bash
cd examples/01_single_bucket
tofu init
tofu plan
tofu apply
```

To run the multiple buckets example:

```bash
cd examples/02_multiple_buckets
tofu init
tofu plan
tofu apply
```

If you prefer Terraform, replace `tofu` with `terraform`.

---

## Related Resources

- [FoggyKitchen OCI Object Storage Module (terraform-oci-fk-objectstorage)](../)
- [FoggyKitchen OCI File Storage Module (terraform-oci-fk-filestorage)](https://github.com/mlinxfeld/terraform-oci-fk-filestorage)
- [FoggyKitchen Azure Storage Module (terraform-az-fk-storage)](https://github.com/mlinxfeld/terraform-az-fk-storage)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.

---

© 2026 FoggyKitchen.com - Cloud. Code. Clarity.
