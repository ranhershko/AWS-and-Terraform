resource "aws_s3_bucket" "opschl-terraform" {
  bucket = "opsschool-terraform-remote-state"

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
  #tags = {
    #Name = "opschl-terraform-remote-state"
  #}
}

resource "aws_dynamodb_table" "opschl-terraform" {
  name         = "opsschool-terraform-remote-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  #tags = {
    #Name = "opschl-terraform-remote-lock"
  #}
}
