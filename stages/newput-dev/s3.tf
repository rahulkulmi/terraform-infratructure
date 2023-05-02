# s3 buckets for microservices
resource "aws_s3_bucket" "newput_react_web" {
  bucket        = "newput-${var.stage}-react-web"
  force_destroy = true

  tags = merge(local.tags, {
    Name = "newput-${var.stage}-react-web"
  })
}

resource "aws_s3_bucket_ownership_controls" "newput_react_web_ownership_controls" {
  bucket = aws_s3_bucket.newput_react_web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "newput_react_web_bucket_acl" {
  bucket = aws_s3_bucket.newput_react_web.id
  acl    = "private"
}
