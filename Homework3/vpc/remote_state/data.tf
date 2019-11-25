provider "aws" {
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
}

data "aws_caller_identity" "current" {
}
