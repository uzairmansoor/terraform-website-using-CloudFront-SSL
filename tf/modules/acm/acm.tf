resource "aws_acm_certificate" "acmCertificate" {
  domain_name               = var.rootDomainName
  subject_alternative_names = var.alternateSubDomains
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "route53DnsRecords" {
  allow_overwrite = true
  name =  tolist(aws_acm_certificate.acmCertificate.domain_validation_options)[0].resource_record_name
  records = [tolist(aws_acm_certificate.acmCertificate.domain_validation_options)[0].resource_record_value]
  type = tolist(aws_acm_certificate.acmCertificate.domain_validation_options)[0].resource_record_type
  zone_id = "Z0908108FRIDHUGQC9S7"
  ttl = 60
}
resource "aws_acm_certificate_validation" "acmCertificateValidation" {
  certificate_arn = aws_acm_certificate.acmCertificate.arn
  validation_record_fqdns = [aws_route53_record.route53DnsRecords.fqdn]
}