data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "opschl-web-db-ha-terrform-remote-state"
    key    = "vpc-terrform.tfstate"
    region = "us-east-1"
  }
}


