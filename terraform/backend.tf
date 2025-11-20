# terraform/backend.tf
# Backend configuration separated for better organization

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket1243"
    key            = "lambda/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}