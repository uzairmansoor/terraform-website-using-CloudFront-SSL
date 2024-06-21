variable "project" {
  type = string
  description = "Project name"
}
variable "env" {
  type = string
  description = "Environment name"
}
variable "app" {
  type = string
  description = "App name"
}
variable "s3BucketOwnership" {
  type = string
  description = "Ownership of an S3 bucket"
  default = "BucketOwnerPreferred"
  validation {
    condition = contains(["BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced"], var.s3BucketOwnership)
    error_message = "Valid value is one of the following: BucketOwnerPreferred, ObjectWriter, BucketOwnerEnforced"
  }
}
variable "s3BucketAcl" {
  type = string
  description = "ACLs, Public or Private"
  default = "public-read"
}
variable "s3BucketForceDestroy" {
  type = string
  description = "Forcefully delete an S3 Bucket along with the objects"
  default = "true"
}
variable "s3BucketIndexDocument" {
  type = string
  description = "Suffic for Static Website Hosting"
  default = "index.html"
}
variable "s3BucketErrorDocument" {
  type = string
  description = "Key for Static Website Hosting"
  default = "error.html"
}
variable "s3BucketVersioning" {
  type = string
  description = "S3 Bucket Versioning Status"
  default = "Enabled"
}