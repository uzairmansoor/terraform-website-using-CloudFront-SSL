variable "s3BucketName" {
  type = string
  description = "S3 bucket name"
}
variable "s3BucketArn" {
  type = string
  description = "S3 bucket ARN"
}
variable "cloudFrontOAIArn" {
  type = string
  description = "S3 cloudfront distribution Origin Access Identity ARN"
}