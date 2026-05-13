variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "region" {
  type = string
}

variable "availability_domain" {
  type    = string
  default = null
}

variable "compartment_ocid" {
  type = string
}
