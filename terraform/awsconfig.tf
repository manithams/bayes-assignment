provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "tf-state-msilva-kops"
    key    = "prod/terraform"
    region = "eu-central-1"
  }
}