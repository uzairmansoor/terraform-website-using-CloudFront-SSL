output "route53HostedZoneId" {
  value = aws_route53_zone.hosted_zone[0].id
}