terraform {
  # To use S3 as the remote backend, comment out the below line
  backend "remote" {}

  # To use S3 as the backend, uncomment the below line
  #backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Sample module that provisions an AWS API Gateway. Replace with the module that configures the specific AWS resource you wish to provision 
module "http_api_gateway" {
  source                       = "./modules/http-api-gateway"
  http_api_gateway_name        = var.http_api_gateway_name
  http_api_gateway_description = var.http_api_gateway_description
  count                        = 0
}