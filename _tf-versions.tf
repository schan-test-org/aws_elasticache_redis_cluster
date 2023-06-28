############################################
# version of terraform and providers
#############################/Volumes/ETC-DATA/_PSA-GD/_____SRCCODE-LEC/___LEC-others/___EXSRC-BASE/_____GITHUB-OPENsrc/__PSA/___PSA-ORG-REPO&/___TEST-ORG/____tmp-test/__EKS-test-TFC/__00-testing-tf/_EX-RDS/__common-locals.tf###############
terraform {
  cloud {
    organization = "schan-test"

    workspaces {}
  }
}

############################################
# AWS Provider Configuration
############################################
provider "aws" {
  region = var.aws_region
  # profile = var.aws_profile

}


# terraform {
#   required_version = ">= 0.12"

#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       # Version 5.x introduces some breaking changes for aws_elasticache_* resources
#       # and this module does not support it
#       version = "< 5.0.0"
#     }
#   }
# }
