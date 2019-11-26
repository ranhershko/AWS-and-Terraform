terraform {
  backend "s3" {
    encrypt = true
    bucket  = "opsschool-terraform-remote-state"
    key     = "opschl-ha-web-db-terrform.tfstate"
    region  = "us-east-1"

    dynamodb_table = "opsschool-terraform-remote-lock"
  }
}
