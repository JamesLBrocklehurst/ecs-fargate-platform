terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.51.0"
    }
  }
  backend "s3" {
    bucket         = "gatus-terraform-state-701632806466"
    key            = "gatus/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "gatus-terraform-locks"
  }
}
