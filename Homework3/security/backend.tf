terraform {
  backend "s3" {
    encrypt = true
    bucket  = "opschl-web-db-ha-terrform-remote-state"
    key     = "security-terrform.tfstate"
    region  = "us-east-1"

    dynamodb_table = "opschl-web-db-ha-security-terrform-remote-lock"
  }
}
