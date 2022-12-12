# terraform {
#   cloud {
#     organization = "nikhil-org-001"

#     workspaces {
#       # name = "cli-driven-wsp"
#       name = "api-driven-workspace-cicd"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket = "bucket-nikhil-01"
    key    = "terraform/backend/terraform.tfstate"
    region = "ap-south-1"
  }
}