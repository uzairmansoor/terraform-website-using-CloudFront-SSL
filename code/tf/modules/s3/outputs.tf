output "s3BucketName" {
  value = aws_s3_bucket.s3Bucket.id
}
output "s3BucketDomainName" {
  value = aws_s3_bucket.s3Bucket.bucket_domain_name
}
output "s3BucketArn" {
  value = aws_s3_bucket.s3Bucket.arn
}
output "s3BucketWebsiteDomain" {
  value = aws_s3_bucket_website_configuration.s3BucketWebsiteConfig.website_domain
}