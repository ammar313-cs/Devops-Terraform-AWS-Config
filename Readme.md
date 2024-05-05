#AWS Infrastructure Deployment with Terraform




Introduction
This repository contains Terraform configurations for deploying a web application infrastructure on Amazon Web Services (AWS). This README provides detailed instructions for deploying and testing the infrastructure.

Prerequisites
Before you begin, ensure you have the following prerequisites:

Terraform installed on your local machine.
AWS credentials configured with appropriate permissions. You can set up AWS credentials using the AWS CLI or environment variables.

Deployment Steps
Follow these steps to deploy the infrastructure:

1. Clone this repository to your local machine:
git clone <repository_url>

2.Navigate to the project directory:
cd aws-terraform-webapp

3.Initialize Terraform:
terraform init

You can customize the VPC CIDR block, instance types, and other settings to match your requirements.

Create a Terraform execution plan:
terraform plan

Apply the Terraform configuration to create the infrastructure:
terraform apply

Wait for Terraform to provision the resources. The process may take a few minutes.
After provisioning is complete, Terraform will display the outputs, including the public and private IP addresses of the EC2 instances.
