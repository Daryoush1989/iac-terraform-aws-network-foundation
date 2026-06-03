# IaC Terraform AWS Network Foundation

## Overview

IaC Terraform AWS Network Foundation is an Infrastructure as Code project that builds a reusable AWS VPC network foundation with separate dev, stage, and prod environment folders.

The repository focuses on Terraform structure, remote state, state locking, repeatable environment configuration, and core AWS networking concepts.

## Business Problem

Cloud teams need reliable network foundations before they can deploy applications. A repeatable VPC module helps reduce manual console work, standardize subnet design, and support safer multi-environment deployments.

## Architecture

High-level architecture:

```text
Terraform environment folder
  -> Shared VPC module
  -> VPC with DNS support
  -> Public subnets across availability zones
  -> Private subnets across availability zones
  -> Internet Gateway for public subnet egress
  -> Single NAT Gateway for cost-aware private subnet egress
  -> Route tables and subnet associations
  -> Environment-specific remote state
```

## AWS Services Used

- Amazon VPC
- Public and private subnets
- Internet Gateway
- NAT Gateway
- Elastic IP for NAT
- Amazon S3 remote state backend
- DynamoDB state locking
- AWS IAM through provider credentials and pipeline roles

## Tools Used

- Terraform
- AWS provider for Terraform
- GitHub Actions workflow files
- Git and GitHub

## Security Features

- Environment-specific Terraform state keys for dev, stage, and prod
- Encrypted S3 remote state configuration
- DynamoDB locking to reduce concurrent state modification risk
- Private subnets with no direct public IP assignment
- Centralized module structure for consistent tagging and naming

## Deployment Summary

The repository contains:

- `modules/vpc` for reusable VPC infrastructure
- `environments/dev`
- `environments/stage`
- `environments/prod`

Each environment has its own Terraform configuration and `terraform.tfvars` values. The checked `terraform.tfvars` files contain only non-secret example values such as organization, environment, app name, and region.

No Terraform or AWS commands were run during this README refresh.

## Testing and Validation

Validation should include Terraform formatting, validation, plan review, and confirmation that each environment uses the correct backend key and variable values. GitHub Actions workflows are present for environment-specific Terraform automation.

## Evidence / Screenshots

This repository does not currently include a `docs` directory or screenshot evidence. Public evidence could be added later using sanitized Terraform plans, diagrams, or console screenshots with placeholders such as `<vpc-id>`, `<subnet-id>`, `<aws-account-id>`, and `<region>`.

## Cost Control

This design uses a single NAT Gateway to reduce lab cost. A production design may use one NAT Gateway per availability zone for improved resilience, but that increases hourly cost.

## Cleanup

Destroy environment resources with the matching Terraform environment when they are no longer needed. Confirm that NAT Gateways, Elastic IPs, and state resources are reviewed because they can create ongoing cost or operational dependencies.

## Lessons Learned

- Terraform modules help standardize network builds across environments.
- Remote state and locking are important for team-safe infrastructure management.
- A cost-aware lab design may choose a single NAT Gateway while documenting the resilience tradeoff.
- Environment separation reduces accidental cross-environment changes.

## Future Improvements

- Add VPC endpoints for S3 and DynamoDB to reduce NAT traffic.
- Add VPC Flow Logs for audit and troubleshooting.
- Add a sanitized architecture diagram.
- Add pre-commit checks for Terraform formatting and validation.
- Add production-grade NAT per AZ as an optional module setting.
