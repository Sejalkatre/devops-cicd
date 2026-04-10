terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"   # lock to AWS provider 5.x
    }
  }
}

provider "aws" {
  region = var.region
}
