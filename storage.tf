resource "aws_s3_bucket" "aws-storage1" {
  bucket = "aws-storage1"
  acl    = "public-read-write"
}
