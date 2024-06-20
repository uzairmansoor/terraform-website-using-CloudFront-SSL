provider "aws" {
  region = var.region
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# module "route53" {
#   source                  = "../../modules/route53"
# }
module "s3" {
  source                  = "../../modules/s3"
  s3BucketName            = "${var.project}-${var.env}-static-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}
module "s3BucketCfLogs" {
  source                  = "../../modules/s3"
  s3BucketName            = "${var.project}-${var.env}-cflogs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}
module "acm" {
  source                  = "../../modules/acm"
}
module "cloudFront" {
  source                  = "../../modules/cloudFront"
  s3BucketName            = module.s3.s3BucketName
  s3BucketWebsiteDomain = module.s3.s3BucketWebsiteDomain
  awsAcmCertificateArn    = module.acm.awsAcmCertificateArn
  cfLogS3BucketName       = module.s3BucketCfLogs.s3BucketName
  albDnsName              = "deleteme-umair-alb-1693925718.us-east-1.elb.amazonaws.com"
  cfCustomCacheBehaviourPath  = "/blog/*"
  # createRoute53HostedZoneId = module.route53.route53HostedZoneId
}
module "s3BucketPolicy" {
  source                  = "../../modules/s3BucketPolicy"
  s3BucketName            = module.s3.s3BucketName
  s3BucketArn             = module.s3.s3BucketArn
  cloudFrontOAIArn        = module.cloudFront.cloudFrontOAIArn
}