## Why this repo exists
This repo builds an AWS “network foundation” using Terraform:
- VPC with public + private subnets (2 AZs)
- Internet Gateway (IGW)
- Single NAT Gateway (cost-saving)
- Remote state (S3) + state locking (DynamoDB)
- GitHub Actions CI/CD using OIDC (no long-lived AWS keys)

## Why remote state + locking matters
Terraform needs to remember what it created (state).
- **S3 remote state** keeps state centralized instead of on a laptop.
- **DynamoDB locking** prevents two Terraform runs from changing the same infrastructure at the same time (avoids corruption).

## Why multi-env matters
This repo uses the same code for:
- dev
- stage
- prod

Each environment has its own Terraform state file, so they don’t interfere with each other.

## Real production improvements (next steps)
- **NAT per AZ:** In real prod you often deploy 1 NAT Gateway per AZ to avoid a single point of failure (costs more).
- **VPC endpoints:** Add S3/DynamoDB endpoints to reduce NAT traffic and cost.
- **Flow Logs:** Enable VPC Flow Logs for network troubleshooting and audit.
