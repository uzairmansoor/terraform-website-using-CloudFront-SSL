data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "s3Bucket" {
  bucket              = "${var.project}-${var.env}-${var.app}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  force_destroy       = var.s3BucketForceDestroy
  tags = {
    name = "${var.project}-${var.env}-${var.app}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
    project = var.project
    app = var.app
    env = var.env
  }
}
resource "aws_s3_bucket_ownership_controls" "s3BucketOwnership" {
  bucket = aws_s3_bucket.s3Bucket.id
  rule {
    object_ownership = var.s3BucketOwnership
  }
}
resource "aws_s3_bucket_acl" "s3BucketEnableAcl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3BucketOwnership]
  bucket = aws_s3_bucket.s3Bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_public_access_block" "s3BucketBlockPublicAccess" {
  bucket                  = aws_s3_bucket.s3Bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "s3BucketWebsiteConfig" {
  bucket = aws_s3_bucket.s3Bucket.id
  index_document {
    suffix = var.s3BucketIndexDocument
  }
  error_document {
    key = var.s3BucketErrorDocument
  }
}
resource "aws_s3_bucket_versioning" "s3BucketVersioning" {
  bucket = aws_s3_bucket.s3Bucket.id
  versioning_configuration {
    status = var.s3BucketVersioning
  }
}