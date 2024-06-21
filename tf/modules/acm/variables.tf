variable "region" {
  type = string
  description = "Region Name"
}
variable "rootDomainName" {
  type = string
  description = "Domain Name"
}
variable "alternateSubDomains" {
  type        = list(string)
  description = "List of Domain Names"
}