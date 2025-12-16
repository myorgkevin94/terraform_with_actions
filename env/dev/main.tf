terraform {
  backend "s3" {
    bucket         = "terraform-with-actions-bucket-kh94"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-with-actions-locks-kh94"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

module "app_bucket" {
  source           = "../../modules/s3_bucket"
  bucket_name      = "myapp-${terraform.workspace}-bucket-${random_id.suffix.hex}"
  enable_versioning = true
  tags = { env = terraform.workspace }
}

