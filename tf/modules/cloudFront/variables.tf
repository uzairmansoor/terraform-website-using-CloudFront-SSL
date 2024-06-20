variable "rootDomainName" {
  type = string
  description = "Website root domain name"
  default     = "goldirahedge.com"
}
variable "cfDistComment" {
  type = string
  description = "CloudFront Distribution Description"
  default     = "Production cloudfront for website"
}
variable "cfDistAllowedMethods" {
  type = list(string)
  description = "CloudFront Distribution Allowed Methods"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}
variable "cfDistCachedMethods" {
  type = list(string)
  description = "CloudFront Distribution Cached Methods"
  default     = ["GET", "HEAD"]
}
variable "s3BucketName" {
  type = string
  description = "S3 bucket name"
}
variable "cfLogS3BucketName" {
  type = string
  description = "Cloudfront logs S3 bucket name"
}
variable "cfDistViewerProtocolPolicy" {
  type = string
  description = "CloudFront Distribution Viewer Protocol Policy"
  default     = "redirect-to-https"
}
variable "cfDefaultRootObject" {
  description = "(Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. Defaults to index.html"
  type        = string
  default     = "index.html"
}
variable "isIpv6Enable" {
  description = "(Optional) - Whether the IPv6 is enabled for the distribution. Defaults to true"
  type        = bool
  default     = true
}
variable "cfHttpVersion" {
  description = "(Optional) - The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2."
  type        = string
  default     = "http2"
}
variable "s3BucketWebsiteDomain" {
  type = string
  description = "S3 bucket website domain"
}
variable "cfPriceClass" {
  description = "(Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100. Defaults to PriceClass_100"
  type        = string
  default     = "PriceClass_100"
}
variable "cfGeoRestrictionType" {
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. Defaults to none"
  type        = string
  default     = "none"
}
variable "cfGeoRestrictionLocations" {
  description = "(Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). Defaults to []"
  type        = list(string)
  default     = []
}
variable "create_acm_certificate" {
  description = "Enable or disable automatic ACM certificate creation. If set to false, the variable acm_certificate_arn_to_use is required. Defaults to true"
  type        = bool
  default     = true
}
variable "awsAcmCertificateArn" {
  description = "ARN of ACM certificate"
  type        = string
}
variable "acm_certificate_arn_to_use" {
  description = "ACM Certificate ARN to use in case you disable automatic certificate creation. Certificate must be in us-east-1 region."
  type        = string
  default     = ""
}
variable "cfRetainOnDelete" {
  description = "(Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Defaults to false."
  type        = bool
  default     = false
}
variable "cfWaitForDeployment" {
  description = "(Optional) - If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. Defaults to true."
  type        = bool
  default     = true
}
variable "create_route53_hosted_zone" {
  description = "Enable or disable Route 53 hosted zone creation. If set to false, the variable route53_hosted_zone_id is required. Defaults to true"
  type        = bool
  default     = false
}
# variable "createRoute53HostedZoneId" {
#   description = "The newly created Route 53 hosted zone ID"
#   type        = string
# }
variable "route53HostedZoneId" {
  description = "The Route 53 hosted zone ID to use if create_route53_hosted_zone is false"
  type        = string
  default     = ""
}
variable "wwwSubDomainName" {
  type = string
  description = "Domain Name"
  default = "www.goldirahedge.com"
}
variable "albDnsName" {
  type = string
  description = "Application load balancer DNS Name"
}
variable "cfOriginProtocolPolicy" {
  type = string
  description = "Cloudfront origin protocol policy"
  default = "http-only"
  validation {
    condition = contains(["http-only", "https-only", "match-viewer"], var.cfOriginProtocolPolicy)
    error_message = "Valid value is one of the following: http-only, https-only, match-viewer"
  }
}
variable "cfViewerProtocolPolicy" {
  type = string
  description = "Cloudfront viewer protocol policy"
  default = "redirect-to-https"
  validation {
    condition = contains(["allow-all", "https-only", "redirect-to-https"], var.cfViewerProtocolPolicy)
    error_message = "Valid value is one of the following: allow-all, https-only, redirect-to-https"
  }
}
variable "cfCustomCacheBehaviourPath" {
  type = string
  description = "Cloudfront cache behaviour path pattern"
}