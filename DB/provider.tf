terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = ">= 5.0"
    random = ">= 3.1"
  }

}

provider "aws" {
  region = var.regionDefault
}
