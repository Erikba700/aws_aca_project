terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

data "aws_s3_bucket" "my_bucket" {
  bucket = "shorternerbucket"
}

resource "aws_s3_object" "static_website_html" {
  bucket = data.aws_s3_bucket.my_bucket.bucket
  key    = "static_s3_template.html"
  source = "../templates/static_s3_template.html"
}