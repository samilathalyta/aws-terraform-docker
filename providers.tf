provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "shop-porto-bucket"
    key    = "terraform/state"
    region = "us-east-1"
  }
}