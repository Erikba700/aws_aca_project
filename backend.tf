terraform {
  backend "s3" {
    bucket         = "shorternerbucket"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    key            = "shortener.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}