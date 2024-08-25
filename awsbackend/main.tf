terraform {
  # Run init/plan/apply with "backend" commented-out (ueses local backend) to provision Resources (Bucket, Table)
  # Then uncomment "backend" and run init, apply after Resources have been created (uses AWS)
/*
  backend "s3" {
    bucket         = "terraform-state-backend-cicd"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
*/

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  shared_credentials_file = "/home/cvaldess/.aws/credentials"
  profile                 = "carlosvaldescu"
  region                  = "eu-west-1"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "terraform-state-backend-cicd"
}

module "vpc-infra" {
  source = "./modules/vpc"

  # VPC Input Vars
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}
