resource "aws_dynamodb_table" "opschl-terraform" {
  name         = "opschl-web-db-ha-instance-terrform-remote-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
