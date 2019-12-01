resource "aws_s3_bucket" "opschl-nginx-accesslog" {
  bucket = "${var.opschl_tags["prefix_name"]}-nginx-accesslog"

  versioning {
    enabled = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
