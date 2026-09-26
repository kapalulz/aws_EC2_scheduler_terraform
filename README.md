# AWS EC2 Scheduler with Terraform

Infrastructure as Code for starting and stopping EC2 instances on a schedule.

The project combines Terraform-managed AWS resources with Lambda functions and scheduled expressions so non-production instances can be stopped outside working hours and started when needed.

## Components

- Terraform configuration for IAM and Lambda resources
- Lambda scripts for EC2 start/stop operations
- Schedule configuration based on cron expressions
- Variables and outputs for environment-specific settings

## Prerequisites

- Terraform
- AWS credentials configured through the standard credential chain
- IAM permissions for Lambda, EC2, logging, and the scheduling service

## Usage

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

Before applying, review:

- Target instance selection
- AWS Region
- Schedule expressions and their time zone
- Lambda IAM permissions
- Expected start/stop behavior during holidays and maintenance windows

## Operations

Check Lambda logs after deployment and test the functions against disposable instances before enabling the production schedule.

```bash
terraform destroy
```

> Scheduled shutdown can interrupt workloads. Exclude stateful or business-critical instances unless their recovery behavior has been tested.
