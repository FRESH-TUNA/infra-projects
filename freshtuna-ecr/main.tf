terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = ">= 3.50.0"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}


resource "aws_ecr_repository" "knufesta2019" {
  name                 = "knufesta2019"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# resource "aws_ecrpublic_repository" "freshtuna" {
#   provider = aws.us_east_1
#   repository_name = "knufesta2019"
#   # catalog_data {
#   #   about_text        = "About Text"
#   #   architectures     = ["ARM"]
#   #   description       = "Description"
#   #   operating_systems = ["Linux"]
#   #   usage_text        = "Usage Text"
#   # }
# }
