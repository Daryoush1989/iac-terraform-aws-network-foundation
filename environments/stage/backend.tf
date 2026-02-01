terraform {
  backend "s3" {
    bucket         = "acme-tfstate-eu-west-2"
    key            = "iac-terraform-aws-network-foundation/stage/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "acme-tf-locks"
    encrypt        = true
  }
}
