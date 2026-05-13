provider "aws" {
  region = "ap-south-1"
}

# This creates the S3 bucket to store your main project's .tfstate
resource "aws_s3_bucket" "terraform_state" {
  bucket = "digistack-tf-state-${random_id.suffix.hex}" 

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "state_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}
