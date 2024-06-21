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

```bash
git clone <repository-url>
cd terraform-website-using-CloudFront-SSL/tf/environments/dev

### Ensure you run the following commands in the directory where your main.tf file is located ###

### Step 2: Initialize Terraform

### Initialize the Terraform configuration and prepare the working directory ###
terraform init

### Step 3: Update Variables

### Update the variable values in the main.tf file to fit your scenario ###

### Step 4: Initialize Terraform

### Create an execution plan and save it to a file named plan.out ###
terraform plan -out plan.out

### Step 4: Apply the Execution Plan

### Apply the changes specified in the saved plan file plan.out ###
terraform apply plan.out

### Step 5: Destroy the Infrastructure

### Destroy the managed infrastructure ###
terraform destroy

