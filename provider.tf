terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44.0"
    }
  }

  backend "s3" {
    bucket       = "digistack-tf-state-6bb4b9f3" # Your newly created bucket
    key          = "digistack/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true 
  }
}

provider "aws" {
  region = var.aws_region
}
