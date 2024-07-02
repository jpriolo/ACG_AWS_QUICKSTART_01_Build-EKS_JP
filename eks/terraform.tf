# terraform {

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.18.0"
#     }
#   }

terraform {

  # backend "s3" {
  #   # bucket         	   = "jpriolo-acg-s3-terraform--01"xm
  #   bucket         	   = "jpriolo-s3-demo-terraform"
  #   key              	 = "state/terraform.tfstate"
  #   region             = "us-east-1"
  #   encrypt        	   = true
  #   # dynamodb_table     = "mycomponents_tf_lockid"
  # }

  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4.46.0"
    # }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.51.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
    }
  }

  required_version = "~> 1.3"
}
