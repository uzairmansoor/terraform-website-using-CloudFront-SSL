# Infrastructure Deployment

This repository contains Terraform configuration files to deploy an AWS infrastructure setup including ACM (AWS Certificate Manager), CloudFront distribution, Route 53 DNS records, S3 bucket configurations, and policies. This setup is designed to host a static website securely on AWS.

## Prerequisites

Before you begin, ensure you have the following:

1. AWS account credentials configured locally with appropriate permissions.
2. Terraform installed on your local machine. You can download it [here](https://www.terraform.io/downloads.html).
3. AWS CLI installed and configured with access to your AWS account.

## Setup Instructions

Follow these steps to deploy the infrastructure:

### Step 1: Clone the Repository and Navigate to the Directory

Clone this repository to your local machine:

```
git clone <repository-url>

cd terraform-website-using-CloudFront-SSL/code/tf/environments/dev
```

Ensure you run the following commands in the directory where your `main.tf` file is located

### Step 2: Initialize Terraform

* Initialize the Terraform configuration and prepare the working directory

```
terraform init
```

### Step 3: Update Variables

* Update the variable values in the `main.tf` file according to your scenario. For example, rootDomainName, alternateSubDomains, albDnsName, wwwSubDomainName, cfUpdateRoute53Records, route53HostedZoneId, etc.

Note:
If you have already created a HostedZone, you need to update its HostedZone ID in the variable named `route53HostedZoneId`. Otherwise, you need to uncomment the route53 code block in the `main.tf` file and update the lines where the HostedZone ID should be referenced.

### Step 4: Create an Execution Plan

* Create an execution plan and save it to a file named `plan.out`

```
terraform plan -out plan.out
```

### Step 4: Apply the Execution Plan

* Apply the changes specified in the saved plan file `plan.out`

```
terraform apply plan.out
```

Now, you need to access your domain, so you'll have to upload the index.html file to the S3 bucket. Secondly, ensure that your WordPress configurations on the EC2 instance are accessible via /blog/.

To access the S3 bucket: https://{domain.com}   OR  www.https://{domain.com}

To access the S3 bucket: https://{domain.com}/blog/ OR  www.https://{domain.com}/blog/

### Step 5: Destroy the Infrastructure

* Destroy the managed infrastructure

```
terraform destroy
```