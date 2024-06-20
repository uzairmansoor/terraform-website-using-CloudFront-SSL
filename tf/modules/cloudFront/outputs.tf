output "cloudFrontDistributionArn" {
  value = aws_cloudfront_distribution.cloudFrontDistribution.arn
}
output "cloudFrontOAIArn" {
  value = aws_cloudfront_origin_access_identity.cfOriginAccessIdentity.iam_arn
}