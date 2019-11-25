resource "aws_s3_bucket" "opschl-terraform" {
  bucket = "opschl-web-db-ha-terrform-remote-state"

  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "opschl-terraform" {
  name         = "opschl-web-db-ha-vpc-terrform-remote-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
