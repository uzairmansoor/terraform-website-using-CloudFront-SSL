# Infrastructure Deployment README

This repository contains Terraform configuration files to deploy an AWS infrastructure setup including ACM (AWS Certificate Manager), CloudFront distribution, Route 53 DNS records, S3 bucket configurations, and policies. This setup is designed to host a static website securely on AWS.

## Prerequisites

Before you begin, ensure you have the following:

1. AWS account credentials configured locally with appropriate permissions.
2. Terraform installed on your local machine. You can download it [here](https://www.terraform.io/downloads.html).
3. AWS CLI installed and configured with access to your AWS account.

## Setup Instructions

Follow these steps to deploy the infrastructure:

### Step 1: Clone the Repository

Clone this repository to your local machine:

```bash
git clone <repository-url>
cd terraform-website-using-CloudFront-SSL/tf/environments/dev

terraform init

terraform plan -out plan.out

terraform apply plan.out

terraform destroy

