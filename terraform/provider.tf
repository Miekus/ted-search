terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
  bucket = "mateusz-kiszka-ted-search"
  key = "terraform.tfstate"
  region = "eu-central-1"
  } 
}
provider "aws" {
  region     = "eu-central-1"
}
