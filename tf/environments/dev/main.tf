provider "aws" {
  region = var.region
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# module "route53" {
#   source                  = "../../modules/route53"
#   rootDomainName          = "goldirahedge.com"
# }
module "s3" {
  source                  = "../../modules/s3"
  project                 = "devops-training"
  env                     = "dev"
  app                     = "static"
}
module "s3BucketCfLogs" {
  source                  = "../../modules/s3"
  project                 = "devops-training"
  env                     = "dev"
  app                     = "cflogs"
}
module "acm" {
  source                  = "../../modules/acm"
  region                  = var.region
  rootDomainName          = "goldirahedge.com"
  alternateSubDomains     = ["*.goldirahedge.com"]
}
module "cloudFront" {
  source                  = "../../modules/cloudFront"
  rootDomainName          = "goldirahedge.com"
  s3BucketName            = module.s3.s3BucketName
  s3BucketWebsiteDomain   = module.s3.s3BucketWebsiteDomain
  awsAcmCertificateArn    = module.acm.awsAcmCertificateArn
  cfLogS3BucketDomainName = module.s3BucketCfLogs.s3BucketDomainName
  albDnsName              = "deleteme-umair-alb-1693925718.us-east-1.elb.amazonaws.com"
  cfCustomCacheBehaviourPath  = "/blog/*"
  wwwSubDomainName        = "www.goldirahedge.com"
  cfUpdateRoute53Records  = ["goldirahedge.com"]
  route53HostedZoneId     = "Z0908108FRIDHUGQC9S7"
  # createRoute53HostedZoneId = module.route53.route53HostedZoneId
}
module "s3BucketPolicy" {
  source                  = "../../modules/s3BucketPolicy"
  s3BucketName            = module.s3.s3BucketName
  s3BucketArn             = module.s3.s3BucketArn
  cloudFrontOAIArn        = module.cloudFront.cloudFrontOAIArn
}