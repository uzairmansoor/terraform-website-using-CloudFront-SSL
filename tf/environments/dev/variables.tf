variable "region" {
  type = string
  description = "Region Name"
  default = "us-east-1"
}
variable "project" {
  type = string
  description = "Project name"
  default     = "devops-training"
}
variable "env" {
  type = string
  description = "Environment name"
  default     = "dev"
}
variable "app" {
  type = string
  description = "App name"
  default     = "app"
}