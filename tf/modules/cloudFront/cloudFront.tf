resource "aws_cloudfront_origin_access_identity" "cfOriginAccessIdentity" {
  comment = "OAI to restrict access to AWS S3 content"
}

resource "aws_cloudfront_distribution" "cloudFrontDistribution" {
  aliases = [
    var.rootDomainName,
    "www.${var.rootDomainName}"
  ]
  comment = var.cfDistComment

  # TODO - Add variable for Custom Error Responses
  # custom_error_response (Optional) - One or more custom error response elements (multiples allowed).

  # TODO - Add variables for cache and origin request policies.

  default_cache_behavior {
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
    allowed_methods          = var.cfDistAllowedMethods
    cached_methods           = var.cfDistCachedMethods
    target_origin_id         = var.s3BucketName
    viewer_protocol_policy   = var.cfDistViewerProtocolPolicy
  }
  ordered_cache_behavior {
    path_pattern           = var.cfCustomCacheBehaviourPath
    target_origin_id       = "ALB-${var.albDnsName}"
    viewer_protocol_policy = var.cfViewerProtocolPolicy
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
    compress               = true
  }

  default_root_object = var.cfDefaultRootObject
  enabled             = true
  is_ipv6_enabled     = var.isIpv6Enable
  http_version        = var.cfHttpVersion

  # logging_config {
  #   include_cookies = false
  #   bucket          = var.cfLogS3BucketName
  #   prefix          = "cf-logs"
  # }

  # TODO - Add variable to support ordered_cache_behavior
  # ordered_cache_behavior (Optional) - An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0.

  origin {
    domain_name = "${var.s3BucketName}.s3.amazonaws.com"
    origin_id   = var.s3BucketName
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cfOriginAccessIdentity.cloudfront_access_identity_path
    }
  }
  origin {
    domain_name = var.albDnsName
    origin_id   = "ALB-${var.albDnsName}"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = var.cfOriginProtocolPolicy
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }
  
  price_class = var.cfPriceClass

  restrictions {
    geo_restriction {
      restriction_type = var.cfGeoRestrictionType
      locations        = var.cfGeoRestrictionLocations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.create_acm_certificate ? var.awsAcmCertificateArn : var.acm_certificate_arn_to_use
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  # TODO - Work to add Web ACL variables
  # web_acl_id (Optional) - A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution.
  # To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned.

  retain_on_delete    = var.cfRetainOnDelete
  wait_for_deployment = var.cfWaitForDeployment
}

resource "aws_route53_record" "cfRoute53Record" {
  zone_id = "Z0908108FRIDHUGQC9S7" #var.route53HostedZoneId #var.create_route53_hosted_zone ? var.createRoute53HostedZoneId : var.route53HostedZoneId
  name    = var.rootDomainName
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudFrontDistribution.domain_name
    zone_id                = aws_cloudfront_distribution.cloudFrontDistribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cfWwwRoute53Record" {
  zone_id = "Z0908108FRIDHUGQC9S7" #var.route53HostedZoneId #var.create_route53_hosted_zone ? var.createRoute53HostedZoneId : var.route53HostedZoneId
  name    = var.wwwSubDomainName
  type    = "CNAME"
   ttl    = 300
  records        = ["${var.rootDomainName}"]
}